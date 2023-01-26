from abc import ABC, abstractmethod

import numpy as np
from helpers import unflatten
from operator_graph import OperatorGraph
from path import DirectKeyPath, PaperKeyPath, Path, PathType


# Class modelling a scheduler for compilation
class Scheduler(ABC):
    def __init__(
        self,
        grid_dims: tuple[int, int],
        cnots: list[tuple[int, int]],
        mapping: dict[int, int],
    ) -> None:
        super().__init__()
        self._grid_dims: tuple[int, int] = grid_dims
        self._cnots: list[tuple[tuple[int, int], tuple[int, int]]] = []

        # Translate the CNOTs to the grid
        for cnot in cnots:
            ctrl = unflatten(mapping[cnot[0]], self._grid_dims)
            tgt = unflatten(mapping[cnot[1]], self._grid_dims)

            self._cnots.append((ctrl, tgt))

    @abstractmethod
    def schedule(self) -> list[list[Path]]:
        pass


# Scheduler that does not perform any optimization and simply schedules the
# operations sequentially
class Sequential(Scheduler):
    def schedule(self):
        return [
            [DirectKeyPath(cnot[0], cnot[1]).extend_to_path()] for cnot in self._cnots
        ]


# Scheduler that is based on the paper
class EDPC(Scheduler):
    def schedule(self):
        # Compute operator EDP sets
        # First approach, using the paper's novel algorithm
        operator_edp_sets = self.__build_operator_edp_sets()

        # Split operator EDP sets into operator VDP sets
        q1 = []
        for operator_edp_set in operator_edp_sets:
            p1, p2 = self.__edp_subroutine(operator_edp_set)

            q1.append(p1)

            # Check if two phases are needed
            if p2:
                q1.append(p2)

        # Build operator graph
        operator_graph = OperatorGraph(self._grid_dims, self._cnots)
        operator_graph._build_initial_operator_graph()

        terminal_pairs = self._cnots.copy()  # TODO copy needed?

        # Second approach, using the greedy algorithm
        q2 = []
        while terminal_pairs:
            # Compute as many minimal length shortest path between terminal
            # pairs as possible that do not intersect
            covered_terminal_pairs, p_star = self.__greedy_vdp(
                operator_graph, terminal_pairs
            )

            # Make progress
            assert covered_terminal_pairs != []

            # Remove the covered terminal pairs
            for pair in covered_terminal_pairs:
                terminal_pairs.remove(pair)

            q2.append(p_star)

        # Pick the shorter scheduling of both approaches
        return q1 if len(q1) <= len(q2) else q2
        # return q1   # TODO remove
        # return q2

    # Build edge disjoint operator sets
    def __build_operator_edp_sets(
        self,
    ) -> list[list[PaperKeyPath]]:
        paths = [PaperKeyPath(ctrl, tgt) for ctrl, tgt in self._cnots]

        # Construct operator EDP sets
        operator_edp_sets = [[]]
        for (
            current_path
        ) in paths:  # TODO use graph coloring instead, this is inefficient
            added = False

            # Check if the current path is edge disjoint with all of the paths
            # of any of existing operator EDP sets and that no terminals are shared
            for operator_edp_set in operator_edp_sets:
                conflict = any(
                    not current_path.is_edge_disjoint(set_path)
                    or not current_path.is_terminal_disjoint(set_path)
                    for set_path in operator_edp_set
                )

                # Is edge disjoint with all of the paths of the current operator
                # set and does not share any terminals
                if not conflict:
                    operator_edp_set.append(current_path)
                    added = True
                    break

            # If the current path couldn't be added to any of the existing
            # operator sets, create a new operator set
            if not added:
                operator_edp_sets.append([current_path])

        return operator_edp_sets

    # Split operator EDP set into two operator VDP sets
    def __edp_subroutine(  # TODO slightly different from the paper
        self,
        operator_edp_set: list[PaperKeyPath],
    ) -> tuple[list[Path], list[Path]]:
        paths = [path.extend_to_path() for path in operator_edp_set]

        # For each path pair check if they are vertex disjoint
        paths_to_split_idx = {}
        for i in range(len(paths)):
            for j in range(i + 1, len(paths)):
                if current_crossing_vertices := paths[i].crossing_vertices(paths[j]):
                    if i not in paths_to_split_idx:
                        paths_to_split_idx[i] = set(current_crossing_vertices)
                    else:
                        paths_to_split_idx[i].update(
                            paths_to_split_idx[i].union(current_crossing_vertices)
                        )

        vertex_disjoint_path_idx = [
            i for i in range(len(paths)) if i not in paths_to_split_idx
        ]

        return (
            # When the operator EDP set is not vertex disjoint, fragment it into
            # two operator VDP sets
            self.__fragment_edp_set(paths, vertex_disjoint_path_idx, paths_to_split_idx)
            if paths_to_split_idx != {}
            # Otherwise return the EDP set as is (because it's VDP as well), the empty second phase will be discarded
            else (paths, [])
        )

    # Given crossing vertices and paths, fragment the operator EDP set into two
    # operator VDP sets
    def __fragment_edp_set(
        self,
        paths: list[Path],
        vertex_disjoint_path_idx: list[int],
        paths_to_split_idx: dict[int, set[tuple[int, int]]],
    ) -> tuple[list[Path], list[Path]]:
        # Assign all vertex disjoint paths to the first phase
        p1, p2 = [paths[i] for i in vertex_disjoint_path_idx], []

        for i in paths_to_split_idx:
            current_path = paths[i]
            phase = []

            for j, vertex in enumerate(current_path):
                if vertex in paths_to_split_idx[i]:
                    phase[j - 1] = 2
                    phase.extend((2, 2))
                elif len(phase) == j:
                    phase.append(1)

            current_phase = phase[0]
            current_vertices = [current_path[0]]
            for j in range(1, len(phase)):
                if phase[j] != current_phase:
                    if current_phase == 1:
                        current_vertices.append(current_path[j])
                        p1.append(Path(PathType.PHASE_1, current_vertices))
                    elif current_phase == 2:
                        p2.append(Path(PathType.PHASE_2, current_vertices))

                    current_phase = phase[j]
                    current_vertices = [current_path[j]]
                else:
                    current_vertices.append(current_path[j])

            if current_phase == 1:
                p1.append(Path(PathType.PHASE_1, current_vertices))
            elif current_phase == 2:
                p2.append(Path(PathType.PHASE_2, current_vertices))

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
        used = set()
        for pair in terminal_pairs:
            if pair[0] not in used and pair[1] not in used:
                unique_terminal_pairs.append(pair)
                used.add(pair[0])
                used.add(pair[1])

        covered_terminal_pairs = []
        operator_graph._build_initial_operator_graph()  # TODO do it by only adding back the ancillas that were removed, add a reset function that only restores neighbors etc

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
    def __compute_minimal_length_shortest_path_between_terminal_pairs(
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
