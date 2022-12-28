from abc import ABC, abstractmethod

import numpy as np
from helpers import unflatten
from operator_graph import OperatorGraph
from path import DirectKeyPath, PaperKeyPath, Path


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
        q1 = self.__build_operator_edp_sets()

        # Build operator graph
        operator_graph = OperatorGraph(self._grid_dims, self._cnots)
        operator_graph._build_initial_operator_graph()

        terminal_pairs = self._cnots.copy()  # TODO copy needed?

        # Second approach, using the greedy algorithm
        q2 = []
        while terminal_pairs:
            # Compute as many minimal length shortest path between terminal
            # pairs as possible that do not intersect
            covered_terminal_pairs, p_star = self.__greedy_edp(
                operator_graph, terminal_pairs
            )

            # Make progress
            assert covered_terminal_pairs != []

            # Remove the covered terminal pairs
            for pair in covered_terminal_pairs:
                terminal_pairs.remove(pair)

            q2.append(p_star)

        # Pick the shorter EDP operator set of both approaches
        operator_edp_sets = q1 if len(q1) < len(q2) else q2

        # Split operator EDP sets into operator VDP sets
        res = []
        for operator_edp_set in operator_edp_sets:
            p1, p2 = self.__edp_subroutine(operator_edp_set)

            res.append(p1)

            # Check if two phases are needed
            if p2:
                res.append(p2)

        return res

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
        vertex_disjoint_path_idx = []
        crossing_vertices = {}
        for i in range(len(paths)):
            path_is_vertex_disjoint = True
            for j in range(i + 1, len(paths)):
                if current_crossing_vertices := paths[i].crossing_vertices(paths[j]):
                    path_is_vertex_disjoint = False

                    for crossing_vertex in current_crossing_vertices:
                        assert crossing_vertex not in crossing_vertices
                        crossing_vertices[crossing_vertex] = (i, j)

            #  Check if path is vertex disjoint with all other paths
            if path_is_vertex_disjoint:
                vertex_disjoint_path_idx.append(i)

        return (
            # When the operator EDP set is not vertex disjoint, fragment it into
            # two operator VDP sets
            self.__fragment_edp_set(paths, vertex_disjoint_path_idx, crossing_vertices)
            if crossing_vertices != {}
            # Otherwise return the EDP set as is (because it's VDP as well), the empty second phase will be discarded
            else (paths, [])
        )

    # Given crossing vertices and paths, fragment the operator EDP set into two
    # operator VDP sets
    def __fragment_edp_set(
        self,
        paths: list[Path],
        vertex_disjoint_path_idx: list[int],
        crossing_vertices: dict[tuple[int, int], tuple[int, int]],
    ) -> tuple[list[Path], list[Path]]:
        # Assign all vertex disjoint paths to the first phase
        p1, p2 = [paths[i] for i in vertex_disjoint_path_idx], []

        # Go over all the crossing vertices and split the crossing paths into
        # the two phases such that at no crossing vertex both crossing path
        # fragments are placed in the same phase
        for crossing_vertex in crossing_vertices:
            to_split = crossing_vertices[crossing_vertex][0]

            # Split the crossing paths into the two phases
            for path_idx in crossing_paths_idx:
                first, second = paths[path_idx].split(crossing_vertex)
                p1.extend(first)
                p2.extend(second)

        # Split the crossing paths into the two phases
        # print(splits)  # TODO remove prints, splitting is not working
        # for crossing_paths_idx in splits:
        #     print(crossing_paths_idx)
        #     for path_idx in crossing_paths_idx:
        #         print(path_idx)
        #         first, second = paths[path_idx].split(splits[crossing_paths_idx])
        #         p1.extend(first)
        #         p2.extend(second)

        return p1, p2

    # Greedily compute the set of shortest paths connecting the given terminal
    # pairs that are vertex disjoint
    def __greedy_edp(
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
        operator_graph._build_initial_operator_graph()  # TODO do it by only adding back the ancillas that were removed
        # temp = (
        #     operator_graph.copy()
        # )  # TODO use copy maybe

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
