from abc import ABC, abstractmethod

import numpy as np

from helpers import unflatten
from operator_graph import OperatorGraph
from path import PaperKeyPath, CompletePath, DirectKeyPath


class Scheduler(ABC):
    def __init__(
        self,
        grid_dims: tuple[int, int],
        cnots: list[tuple[int, int]],
        mapping: dict[int, int],
    ) -> None:
        super().__init__()

        self._grid_dims: tuple[int, int] = grid_dims
        self._cnots: list[tuple[int, int]] = cnots
        self._mapping: dict[int, int] = mapping

    @abstractmethod
    def schedule(self) -> list[CompletePath]:
        pass


# Dummy ------------------------------------------------------------------------


class Sequential(Scheduler):
    def schedule(self):
        paths = []

        for cnot in self._cnots:
            start, stop = cnot
            start = unflatten(start, self._grid_dims)
            stop = unflatten(stop, self._grid_dims)

            paths.append(DirectKeyPath(start, stop).to_complete_path())
        return paths


# Paper ------------------------------------------------------------------------


class EDPC(Scheduler):
    def schedule(self):
        operator_graph = OperatorGraph(self._grid_dims, self._mapping, self._cnots)

        operator_edp_sets = operator_graph._build_operator_edp_sets()

        q1 = []
        for operator_edp_set in operator_edp_sets:
            p1, p2 = self.__edp_subroutine(operator_edp_set)
            q1.append(p1)
            if p2:
                q1.append(p2)

        operator_graph._build_initial_operator_graph()
        terminal_pairs = operator_graph._cnots.copy()  # TODO copy needed?
        q2 = []

        while terminal_pairs:
            covered_terminal_pairs, p_star = self.__greedy_edp(
                operator_graph, terminal_pairs
            )

            assert covered_terminal_pairs != []

            terminal_pairs = [
                pair for pair in terminal_pairs if pair not in covered_terminal_pairs
            ]
            q2.extend(p_star)

        return q1 if len(q1) < len(q2) else q2

    def __edp_subroutine(  # TODO different from the paper
        self,
        operator_edp_set: list[PaperKeyPath],
    ) -> tuple[list[CompletePath], list[CompletePath]]:
        # Split into two VDP sets
        paths = [path.to_complete_path() for path in operator_edp_set]

        vertex_disjoint = True
        vertex_disjoint_paths = []
        crossing_vertices = []
        crossing_paths = []
        for i in range(len(paths)):
            path_is_vertex_disjoint = True
            for j in range(i + 1, len(paths)):
                if not paths[i].is_vertex_disjoint(paths[j]):
                    vertex_disjoint = False
                    path_is_vertex_disjoint = False
                    crossing_vertices.append(paths[i])
                    crossing_paths.append((i, j))

            if path_is_vertex_disjoint:
                vertex_disjoint_paths.append(i)

        if vertex_disjoint:
            return paths, []

        return self.__fragment_edp_set(
            paths, vertex_disjoint_paths, crossing_vertices, crossing_paths
        )

    def __fragment_edp_set(
        self,
        paths: list[CompletePath],
        vertex_disjoint_paths: list[int],
        crossing_vertices: list[tuple[int, int]],
        crossing_paths: list[tuple[int, int]],
    ) -> tuple[list[CompletePath], list[CompletePath]]:
        p1, p2 = [paths[i] for i in vertex_disjoint_paths], []

        splits = {}
        for i in range(
            len(crossing_vertices)
        ):  # TODO is this condition sufficient? Does it comply with the constraints on edges etc. in the paper?
            if crossing_paths[i][0] not in splits:
                splits[crossing_paths[i][0]] = [crossing_vertices[i]]
            else:
                no_neighbors = True
                for vertex in splits[crossing_paths[i][0]]:
                    distance = abs(vertex[0] - crossing_vertices[i][0]) + abs(
                        vertex[1] - crossing_vertices[i][1]
                    )
                    assert distance != 0
                    if distance == 1:
                        no_neighbors = False
                        break
                if no_neighbors:
                    splits[crossing_paths[i][0]].append(crossing_vertices[i])
                elif crossing_paths[i][1] in splits:
                    no_neighbors = True
                    for vertex in splits[crossing_paths[i][1]]:
                        distance = abs(vertex[0] - crossing_vertices[i][0]) + abs(
                            vertex[1] - crossing_vertices[i][1]
                        )
                        assert distance != 0
                        if distance == 1:
                            no_neighbors = False
                            break
                    if no_neighbors:
                        splits[crossing_paths[i][1]].append(crossing_vertices[i])
                    else:
                        raise RuntimeError(
                            "Crossing vertex is neighbor to a vertex of both paths!!!!"
                        )  # TODO shouldn't happen, but not sure

                else:
                    splits[crossing_paths[i][1]] = [crossing_vertices[i]]
        for i in splits:
            first, second = paths[i].split(splits[i])
            p1.extend(first)
            p2.extend(second)

        return p1, p2

    def __greedy_edp(
        self,
        operator_graph: OperatorGraph,
        terminal_pairs: list[tuple[tuple[int, int], tuple[int, int]]],
    ) -> tuple[list[tuple[tuple[int, int], tuple[int, int]]], list[CompletePath]]:
        A = []
        covered_terminal_pairs = []

        while terminal_pairs != []:
            (
                shortest_path_terminal_pair,
                p_star,
            ) = self.__compute_minimal_length_shortest_path_between_terminal_pairs(
                operator_graph, terminal_pairs
            )

            if p_star is None:
                return covered_terminal_pairs, A

            A.append([p_star])
            operator_graph._remove_ancillas_in_path(p_star)
            covered_terminal_pairs.append(shortest_path_terminal_pair)
            terminal_pairs.remove(shortest_path_terminal_pair)

        return covered_terminal_pairs, A

    def __compute_minimal_length_shortest_path_between_terminal_pairs(
        self,
        operator_graph: OperatorGraph,
        terminal_pairs: list[tuple[tuple[int, int], tuple[int, int]]],
    ) -> tuple[tuple[tuple[int, int], tuple[int, int]], CompletePath]:
        shortest_path_terminal_pair = None
        shortest_path = None
        length = np.inf

        for terminal_pair in terminal_pairs:
            operator_graph._add_terminal_pair(terminal_pair)
            path = operator_graph._shortest_path(terminal_pair[0], terminal_pair[1])
            operator_graph._remove_terminal_pair(terminal_pair)

            if path is not None and len(path) < length:
                length = len(path)
                shortest_path = path
                shortest_path_terminal_pair = terminal_pair

        return shortest_path_terminal_pair, shortest_path
