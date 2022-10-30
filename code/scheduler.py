from abc import ABC, abstractmethod

from helpers import is_data_qubit
from operator_graph import OperatorGraph, Path


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
        graph = OperatorGraph(self._grid_dims)

        list_operator_edp_sets, list_crossing_vertices = graph.build_operator_edp_sets(
            self._mapping, self._cnots
        )

        scheduling = []
        for i in range(len(list_operator_edp_sets)):
            q1 = self.__edp_subroutine(
                list_operator_edp_sets[i], list_crossing_vertices[i]
            )

            q2 = []
            while self._cnots:
                terminals, p = self.__greedy_edp()
                self._cnots = [cnot for cnot in self._cnots if cnot not in terminals]
                q2.extend(p)

            scheduling.append(q1 if len(q1) < len(q2) else q2)

        return scheduling

    def __edp_subroutine(
        self,
        operator_edp_set: list[Path],
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
        operator_edp_set: list[Path],
        crossing_vertices: list[list[tuple[int, int]]],
    ) -> tuple[list[Path], list[list[tuple[int, int]]]]:
        if crossing_vertices == [[]]:
            return operator_edp_set, []

        raise Warning("Not implemented yet")

        # for i, crossing_vertex in enumerate(crossing_vertices):
        #     p1 = operator_edp_set[: i + 1]
        #     p2 = operator_edp_set[i + 1 :]
        # return [], []

    def __greedy_edp(self) -> tuple[list[tuple[int, int]], list[list[tuple[int, int]]]]:
        raise Warning("Not implemented yet")
        # return [], []
