from abc import ABC, abstractmethod

import numpy as np
from operator_graph import OperatorGraph
from path import KeyPath, Path, PathType


# Class modelling a scheduler for compilation
class Scheduler(ABC):
    def __init__(
        self,
        grid_dims: tuple[int, int],
        cnots: list[tuple[tuple[int, int], tuple[int, int]]],
    ) -> None:
        super().__init__()
        self._grid_dims: tuple[int, int] = grid_dims
        self._cnots: list[tuple[tuple[int, int], tuple[int, int]]] = cnots

    @abstractmethod
    def schedule(self) -> list[list[Path]]:
        pass


# Helper function that assigns color IDs to the paths in the given scheduling
def assign_color_ids(scheduling: list[list[Path]]) -> None:
    color_id = 0

    for epoch in scheduling:
        for path in epoch:
            path.set_color_id(color_id)
            color_id += 1


# Scheduler that does not perform any optimization and simply schedules the
# operations sequentially
class Sequential(Scheduler):
    def schedule(self):
        scheduling = [
            [KeyPath(cnot[0], cnot[1]).extend_to_path()] for cnot in self._cnots
        ]

        assign_color_ids(scheduling)

        return scheduling


# Scheduler that is based on the paper
class EDPC(Scheduler):
    def schedule(self):
        # First approach, using the paper's novel algorithm, compute the
        # operator EDP sets
        operator_edp_sets = self.__compute_operator_edp_sets()

        # Assign color IDs to the paths
        assign_color_ids(operator_edp_sets)

        # Split operator EDP sets into operator VDP sets
        q1 = []
        for operator_edp_set in operator_edp_sets:
            p1, p2 = self.__edp_subroutine(operator_edp_set)

            q1.append(p1)

            # Check if two phases are needed
            if p2:
                q1.append(p2)

        # Second approach, using the greedy algorithm, build operator graph
        operator_graph = OperatorGraph(self._grid_dims, self._cnots)

        q2 = []
        while self._cnots:
            # Compute as many minimal length shortest path between terminal
            # pairs as possible that do not intersect
            covered_terminal_pairs, p_star = self.__greedy_vdp(
                operator_graph, self._cnots
            )

            # Make progress
            assert covered_terminal_pairs != []

            # Remove the covered terminal pairs
            for pair in covered_terminal_pairs:
                self._cnots.remove(pair)

            q2.append(p_star)

        # Assign color IDs to the paths
        assign_color_ids(q2)

        # Pick the shorter scheduling of both approaches
        if len(q1) <= len(q2):
            print(f"Using paper approach: len(q1)={len(q1)} vs len(q2)={len(q2)}")
            scheduling = q1
        else:
            print(f"Using greedy approach: len(q1)={len(q1)} vs len(q2)={len(q2)}")
            scheduling = q2

        # Contains at least one empty epoch
        if not scheduling:
            scheduling = [[]]

        return scheduling

    # Compute edge disjoint operator sets
    def __compute_operator_edp_sets(  # TODO Paper suggest to use graph coloring instead, this is just brute force
        self,
    ) -> list[list[Path]]:
        paths = [KeyPath(ctrl, tgt).extend_to_path() for ctrl, tgt in self._cnots]

        # Construct operator EDP sets
        operator_edp_sets = [[]]
        for current_path in paths:
            added = False

            # Check if the current path is edge disjoint with all of the paths
            # of any of existing operator EDP sets and that no terminals are shared
            for operator_edp_set in operator_edp_sets:
                conflict = any(
                    not current_path.is_terminal_disjoint(set_path)
                    or not current_path.is_edge_disjoint(set_path)
                    for set_path in operator_edp_set
                )

                # Is edge disjoint with all of the paths of the current operator
                # set and does not share any terminals
                if not conflict:
                    operator_edp_set.append(current_path)
                    added = True
                    break

            # If the current path couldn't be added to any of the existing
            # operator sets, append a new operator set at the end
            if not added:
                operator_edp_sets.append([current_path])

        return operator_edp_sets

    # Find the vertex disjoint paths in the given operator EDP set, the
    # remaining paths are subsequently split into two operator VDP sets
    def __edp_subroutine(
        self,
        operator_edp_set: list[Path],
    ) -> tuple[list[Path], list[Path]]:
        # For each path pair check if they are vertex disjoint
        paths_to_split_idx = {}
        for i in range(len(operator_edp_set)):
            for j in range(i + 1, len(operator_edp_set)):
                current_crossing_vertices = operator_edp_set[i].crossing_vertices(
                    operator_edp_set[j]
                )

                # If not, keep track of the path and the crossing vertices
                if current_crossing_vertices != set():
                    if i in paths_to_split_idx:
                        paths_to_split_idx[i].update(
                            paths_to_split_idx[i].union(current_crossing_vertices)
                        )
                    else:
                        paths_to_split_idx[i] = set(current_crossing_vertices)

        return (
            # When the operator EDP set is not vertex disjoint, fragment it into
            # two operator VDP sets
            self.__fragment_edp_set(operator_edp_set, paths_to_split_idx)
            if paths_to_split_idx != {}
            # Otherwise return the EDP set as is (because it's VDP as well), the
            # empty second phase will be discarded
            else (operator_edp_set, [])
        )

    # Given the intersecting paths and the crossing vertices, fragment the
    # operator EDP set into two operator VDP sets
    def __fragment_edp_set(
        self,
        paths: list[Path],
        paths_to_split_idx: dict[int, set[tuple[int, int]]],
    ) -> tuple[list[Path], list[Path]]:
        # Compute the vertex disjoint paths
        vertex_disjoint_path_idx = [
            i for i in range(len(paths)) if i not in paths_to_split_idx
        ]

        # Assign all vertex disjoint paths to the first phase
        p1, p2 = [paths[i] for i in vertex_disjoint_path_idx], []

        # Split the remaining paths into two phases
        for i, crossing_vertices in paths_to_split_idx.items():
            current_path = paths[i]
            phases = [1] * len(current_path)

            # Match up the crossing vertices to the second phase with the
            # required vertex before and after the crossing vertex itself
            for j, vertex in enumerate(current_path):
                if vertex in crossing_vertices:
                    assert j > 0 and j < len(current_path) - 1
                    phases[j - 1] = 2
                    phases[j] = 2
                    phases[j + 1] = 2

            phases_1 = []
            phases_2 = []

            # Attribute the vertices to the phases
            last = phases[0]
            for j, p in enumerate(phases):
                # Transition from phase 1 to phase 2
                if p > last:
                    phases_1.append(current_path[j])
                    phases_2.append(current_path[j])
                # Transition from phase 2 to phase 1
                elif p < last:
                    phases_1.extend((current_path[j - 1], current_path[j]))
                # Stay in the phase 1
                elif p == 1:
                    phases_1.append(current_path[j])
                # Stay in the phase 2
                else:
                    phases_2.append(current_path[j])

                last = p

            # Create two new paths for the two phases while maintaining the same
            # color id
            current_color_id = current_path.get_color_id()

            path = Path(PathType.PHASE_1, current_color_id, phases_1)
            p1.append(path)

            assert len(phases_1) > 1

            path = Path(PathType.PHASE_2, current_color_id, phases_2)
            p2.append(path)

            assert len(phases_2) > 1

        return p1, p2

    # Greedily compute the set of shortest paths connecting the given terminal
    # pairs that are vertex disjoint
    def __greedy_vdp(
        self,
        operator_graph: OperatorGraph,
        terminal_pairs: list[tuple[tuple[int, int], tuple[int, int]]],
    ) -> tuple[list[tuple[tuple[int, int], tuple[int, int]]], list[Path]]:
        A: list[Path] = []
        # Remove duplicates, terminals can't be present twice (not just as pairs)
        unique_terminal_pairs = []
        used_terminals = []
        for pair in terminal_pairs:
            if pair[0] not in used_terminals and pair[1] not in used_terminals:
                unique_terminal_pairs.append(pair)
                used_terminals.extend(pair)

        covered_terminal_pairs = []
        operator_graph._restore_initial_state()

        # While not all terminal pairs have been connected
        while unique_terminal_pairs != []:
            # Compute the shortest path between any terminal pair possible in
            # the operator graph
            (
                shortest_path_terminal_pair,
                p_star,
            ) = self.__compute_minimal_length_shortest_path_between_terminal_pairs(
                operator_graph, unique_terminal_pairs
            )

            # If no such path exists, return the current set of paths
            if p_star is None:
                return covered_terminal_pairs, A

            # Remove the ancilla qubits from the operator graph used in the
            # current path
            operator_graph._remove_ancillas_in_path(p_star)
            A.append(p_star)
            covered_terminal_pairs.append(shortest_path_terminal_pair)

            # Remove the covered terminal pair from the list of terminal pairs
            unique_terminal_pairs.remove(shortest_path_terminal_pair)

        return covered_terminal_pairs, A

    # Compute the shortest path between any terminal pair possible in the
    # operator graph
    def __compute_minimal_length_shortest_path_between_terminal_pairs(  # TODO the paper suggests to use Dijkstra's algorithm instead of BFS
        self,
        operator_graph: OperatorGraph,
        terminal_pairs: list[tuple[tuple[int, int], tuple[int, int]]],
    ) -> tuple[tuple[tuple[int, int], tuple[int, int]], Path]:
        shortest_path_terminal_pair = None
        shortest_path = None
        length = np.inf

        # Go over all terminal pairs
        for terminal_pair in terminal_pairs:
            # Add the current terminal pair to the operator graph
            operator_graph._add_terminal_pair(terminal_pair)

            # Compute the shortest path between the two terminal vertices
            path = operator_graph._shortest_path(terminal_pair[0], terminal_pair[1])

            # Remove the current terminal pair from the operator graph again
            operator_graph._remove_terminal_pair(terminal_pair)

            # Check the current path is shorter than the shortest path found so far
            if path is not None and len(path) < length:
                length = len(path)
                shortest_path = path
                shortest_path_terminal_pair = terminal_pair

        return shortest_path_terminal_pair, shortest_path
