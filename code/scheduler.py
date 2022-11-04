from abc import ABC, abstractmethod

import numpy as np

from helpers import is_data_qubit
from operator_graph import OperatorGraph
from path import KeyPath, NormalPath


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
    def schedule(self) -> list[list[tuple[int, int]]]:
        pass


# Dummy ------------------------------------------------------------------------


class Sequential(
    Scheduler
):  # TODO still on grid but without ancillas, we should output a list of [path]
    def schedule(self):
        return [[cnot] for cnot in self._cnots]


# Paper ------------------------------------------------------------------------


class EDPC(Scheduler):
    def schedule(self):
        operator_graph = OperatorGraph(self._grid_dims, self._mapping, self._cnots)

        (
            list_operator_edp_sets,
            list_crossing_vertices,
        ) = operator_graph._build_operator_edp_sets()

        q1 = []
        for i in range(len(list_operator_edp_sets)):
            p1, p2 = self.__edp_subroutine(
                list_operator_edp_sets[i], list_crossing_vertices[i]
            )
            q1.append(p1)
            if p2:
                q1.append(p2)

        operator_graph._build_operator_graph()
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

    def __edp_subroutine(  # TODO technically fragment, subroutine is not needed here, more in compiler
        self,
        operator_edp_set: list[KeyPath],
        crossing_vertices: set[tuple[int, int]],
    ) -> tuple[list[NormalPath], list[NormalPath]]:
        # Split into two VDP sets
        if not crossing_vertices:
            return [path.to_normal_path() for path in operator_edp_set], []

        raise Warning("Not implemented yet")

        # for crossing_vertex in crossing_vertices:
        #     conflicting_paths = [  # TODO apparently exactly two!!! Why?
        #         path for path in operator_edp_set if path.contains(crossing_vertex)
        #     ]

    def __greedy_edp(
        self,
        operator_graph: OperatorGraph,
        terminal_pairs: list[tuple[tuple[int, int], tuple[int, int]]],
    ) -> tuple[list[tuple[tuple[int, int], tuple[int, int]]], list[NormalPath]]:
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
    ) -> tuple[tuple[tuple[int, int], tuple[int, int]], NormalPath]:
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
