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


class Sequential(Scheduler):
    def schedule(self):
        return [[cnot] for cnot in self._cnots]  # TODO Use mapping?


# Paper ------------------------------------------------------------------------


class EDPC(Scheduler):
    def schedule(self):
        operator_graph = OperatorGraph(self._grid_dims, self._mapping, self._cnots)

        (
            list_operator_edp_sets,
            list_crossing_vertices,
        ) = operator_graph._build_operator_edp_sets()

        q1 = [
            self.__edp_subroutine(list_operator_edp_sets[i], list_crossing_vertices[i])
            for i in range(len(list_operator_edp_sets))
        ]

        operator_graph._build_operator_graph()
        terminals = operator_graph._cnots.copy()  # TODO copy?
        q2 = []

        while terminals:
            covered_terminals, p_star = self.__greedy_edp(operator_graph, terminals)

            assert covered_terminals != []

            terminals = [pair for pair in terminals if pair not in covered_terminals]
            q2.extend(p_star)

        return q1 if len(q1) < len(q2) else q2

    def __edp_subroutine(
        self,
        operator_edp_set: list[KeyPath],
        crossing_vertices: list[list[tuple[int, int]]],
    ) -> tuple[
        list[list[tuple[int, int]]],
        list[list[tuple[int, int]]],
        list[list[tuple[int, int]]],
    ]:
        # Split into two VDP sets
        p1, p2 = self.__fragment_operator_edp_set(operator_edp_set, crossing_vertices)

        long_range_cnots = []
        phase1 = []
        phase2 = []

        for segment in p1:
            head = segment[0]
            tail = segment[-1]

            if is_data_qubit(head) and is_data_qubit(tail):
                long_range_cnots.append(segment)
            else:
                phase1.append(segment)

        for segment in p2:
            head = segment[0]
            tail = segment[-1]

            if is_data_qubit(head) and is_data_qubit(tail):
                long_range_cnots.append(segment)
            else:
                phase2.append(segment)

        return long_range_cnots, phase1, phase2

    def __fragment_operator_edp_set(
        self,
        operator_edp_set: list[KeyPath],
        crossing_vertices: list[list[tuple[int, int]]],
    ) -> tuple[list[KeyPath], list[list[tuple[int, int]]]]:
        if crossing_vertices == [[]]:
            return operator_edp_set, []

        raise Warning("Not implemented yet")

    def __greedy_edp(
        self,
        operator_graph: OperatorGraph,
        terminals: list[tuple[tuple[int, int], tuple[int, int]]],
    ) -> tuple[list[tuple[tuple[int, int], tuple[int, int]]], list[NormalPath]]:
        A = []
        covered_terminals = []

        while terminals != []:
            (
                shortest_path_terminal,
                P_star,
            ) = self.__compute_minimal_length_shortest_path_between_terminals(
                operator_graph, terminals
            )

            if P_star is None:
                return covered_terminals, A

            A.append(P_star)
            operator_graph._remove_ancillas_in_path(P_star)
            covered_terminals.append(shortest_path_terminal)
            terminals.remove(shortest_path_terminal)

        return covered_terminals, A

    def __compute_minimal_length_shortest_path_between_terminals(
        self,
        operator_graph: OperatorGraph,
        terminals: list[tuple[tuple[int, int], tuple[int, int]]],
    ) -> tuple[tuple[tuple[int, int], tuple[int, int]], NormalPath]:
        shortest_path_terminal = None
        path = None
        length = np.inf

        for terminal in terminals:
            operator_graph._add_terminal_pair(terminal)
            shortest_path = operator_graph._shortest_path(terminal[0], terminal[1])
            operator_graph._remove_terminal_pair(terminal)

            if shortest_path is not None and len(shortest_path) < length:
                length = len(shortest_path)
                path = shortest_path
                shortest_path_terminal = terminal

        return shortest_path_terminal, path
