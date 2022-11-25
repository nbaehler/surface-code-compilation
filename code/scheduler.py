import itertools
from abc import ABC, abstractmethod

import numpy as np

from helpers import unflatten
from operator_graph import OperatorGraph
from path import PaperKeyPath, Path, DirectKeyPath

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


# Scheduler that is based in the paper
class EDPC(Scheduler):
    def schedule(self):
        # Compute operator EDP sets
        operator_edp_sets = self.__build_operator_edp_sets()

        # First approach, using the paper's novel algorithm
        q1 = []
        for operator_edp_set in operator_edp_sets:
            p1, p2 = self.__edp_subroutine(operator_edp_set)

            q1.append(p1)

            # Check if two phases are needed
            if p2:
                q1.append(p2)

        # Build operator graph and initialize it
        operator_graph = OperatorGraph(self._grid_dims, self._cnots)
        operator_graph._build_initial_operator_graph()
        terminal_pairs = operator_graph._cnots.copy()  # TODO copy needed?

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
            terminal_pairs = [
                pair for pair in terminal_pairs if pair not in covered_terminal_pairs
            ]
            q2.extend(p_star)

        # Pick the shorter scheduling of both approaches
        return q1 if len(q1) < len(q2) else q2

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
            # of any of existing operator EDP sets
            for operator_edp_set in operator_edp_sets:
                share_edges = any(
                    not current_path.is_edge_disjoint(set_path)
                    for set_path in operator_edp_set
                )

                # Is edge disjoint with all of the paths of the current operator set
                if not share_edges:
                    operator_edp_set.append(current_path)
                    added = True
                    break

            # If the current path couldn't be added to any of the existing
            # operator sets, create a new operator set
            if not added:
                operator_edp_sets.append([current_path])

        return operator_edp_sets

    # Split operator EDP set into two operator VDP sets
    def __edp_subroutine(  # TODO different from the paper
        self,
        operator_edp_set: list[PaperKeyPath],
    ) -> tuple[list[Path], list[Path]]:
        paths = [path.extend_to_path() for path in operator_edp_set]

        # For each path pair check if they are vertex disjoint
        vertex_disjoint_path_idx = []
        crossing_vertices = []
        crossing_paths_idx_pairs = []
        for i in range(len(paths)):
            path_is_vertex_disjoint = True
            for j in range(i + 1, len(paths)):
                # If not, keep track of the crossing vertices and paths
                current_crossing_vertices = paths[i].crossing_vertices(paths[j])
                if not current_crossing_vertices:
                    path_is_vertex_disjoint = False
                    crossing_vertices.append(current_crossing_vertices)
                    crossing_paths_idx_pairs.append((i, j))

            #  Check if path is
            if path_is_vertex_disjoint:
                vertex_disjoint_path_idx.append(i)

        return (
            # When the operator EDP set is not vertex disjoint, fragment it into
            # two operator VDP sets
            self.__fragment_edp_set(
                paths,
                vertex_disjoint_path_idx,
                crossing_vertices,
                crossing_paths_idx_pairs,
            )
            if crossing_paths_idx_pairs
            # Otherwise return the EDP set as is, the empty second phase will be discarded
            else (paths, [])
        )

    # Given crossing vertices and paths, fragment the operator EDP set into two
    # operator VDP sets
    def __fragment_edp_set(
        self,
        paths: list[Path],
        vertex_disjoint_path_idx: list[int],
        crossing_vertices: list[tuple[int, int]],
        crossing_paths_idx_pairs: list[tuple[int, int]],
    ) -> tuple[list[Path], list[Path]]:
        # Assign all vertex disjoint paths to the first phase
        p1, p2 = [paths[i] for i in vertex_disjoint_path_idx], []

        # Go over all the crossing vertices and split the crossing paths into
        # the two phases such that at no crossing vertex both crossing path
        # fragments are placed in the same phase
        splits = {}
        for i, j in itertools.product(range(len(crossing_vertices)), range(2)):
            # Check it the crossing path is already marked to be split
            if crossing_paths_idx_pairs[i][j] not in splits:
                splits[crossing_paths_idx_pairs[i][j]] = [crossing_vertices[i]]
            else:
                splits[crossing_paths_idx_pairs[i][j]].append(crossing_vertices[i])

        # Split the crossing paths into the two phases
        for i in splits:
            first, second = paths[i].split(splits[i])
            p1.extend(first)
            p2.extend(second)

        return p1, p2

    # Greedily compute the set of shortest paths connecting the given terminal
    # pairs that are vertex disjoint
    def __greedy_edp(
        self,
        operator_graph: OperatorGraph,
        terminal_pairs: list[tuple[tuple[int, int], tuple[int, int]]],
    ) -> tuple[list[tuple[tuple[int, int], tuple[int, int]]], list[Path]]:
        A = []
        covered_terminal_pairs = []

        # While not all terminal pairs have been connected
        while terminal_pairs != []:
            # Compute the shortest path between any terminal pair possible in
            # the operator graph
            (
                shortest_path_terminal_pair,
                p_star,
            ) = self.__compute_minimal_length_shortest_path_between_terminal_pairs(
                operator_graph, terminal_pairs
            )

            # If no such path exists, return the current set of paths
            if p_star is None:
                return covered_terminal_pairs, A

            # Remove the ancilla qubits from the operator graph used in the
            # current path
            operator_graph._remove_ancillas_in_path(p_star)
            A.append(p_star)
            covered_terminal_pairs.append(shortest_path_terminal_pair)
            terminal_pairs.remove(shortest_path_terminal_pair)

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
