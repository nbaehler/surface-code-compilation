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

    def __edp_subroutine(
        self,
        operator_edp_set: list[PaperKeyPath],
        # crossing_vertices: set[tuple[int, int]],
    ) -> tuple[list[CompletePath], list[CompletePath]]:
        # Split into two VDP sets
        vertex_disjoint = True
        crossing_vertices = []
        crossing_paths = []
        for i in range(len(operator_edp_set)):
            for j in range(i + 1, len(operator_edp_set)):
                if not operator_edp_set[i].is_vertex_disjoint(operator_edp_set[j]):
                    vertex_disjoint = False
                    crossing_vertices.append(operator_edp_set[i])
                    crossing_paths.append((i, j))

        if vertex_disjoint:
            return [path.to_complete_path() for path in operator_edp_set], []

        return self.__fragment_edp_set(
            operator_edp_set, crossing_vertices, crossing_paths
        )

    def __fragment_edp_set(
        self,
        operator_edp_set: list[PaperKeyPath],
        crossing_vertices: list[tuple[int, int]],
        corresponding_paths: list[tuple[int, int]],
    ) -> tuple[list[CompletePath], list[CompletePath]]:
        raise Warning("Not implemented yet")

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
