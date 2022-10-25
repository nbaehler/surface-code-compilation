import itertools
import numpy as np
from abc import ABC, abstractmethod

from helpers import flatten
from operator_graph import OperatorGraph


class Strategy(ABC):
    def __init__(
        self, grid_dims: tuple[int, int], cnots: list[tuple[int, int]]
    ) -> None:
        super().__init__()

        self._grid_dims: tuple[int, int] = grid_dims
        self._cnots: list[tuple[int, int]] = cnots

    @abstractmethod
    def compile(self) -> tuple[int, dict[int, int], list[list[tuple[int, int]]]]:
        pass


# Dummy ------------------------------------------------------------------------


class Sequential(Strategy):
    def compile(self):
        n_qubits = np.prod(self._grid_dims)

        if not self.__mappable(self._cnots, n_qubits):
            raise ValueError(
                f"The input circuit is not mappable to the given grid dimension {self._grid_dims}."
            )

        mapping = {i: i for i in range(n_qubits)}

        schedule = [
            [cnot] for cnot in self._cnots
        ]  # A list of cnots at each time slice

        return n_qubits, mapping, schedule

    def __mappable(self, cnots: list[tuple[int, int]], n_qubits: int):
        return not any(cnot[0] >= n_qubits or cnot[1] >= n_qubits for cnot in cnots)


class Sequential2(Strategy):  # TODO changing the mapping might be tricky
    def compile(self):
        n_max = np.prod(self._grid_dims)
        mapping = {}
        used_indices = set()
        n_qubits = 0

        for cnot in self._cnots:
            for qubit in cnot:
                if qubit not in used_indices:
                    used_indices.add(n_qubits)
                    mapping[qubit] = n_qubits
                    n_qubits += 1

                    if n_qubits > n_max:
                        raise ValueError(
                            f"The input circuit is not mappable to the given grid dimension {self._grid_dims}."
                        )

        scheduling = [
            [cnot] for cnot in self._cnots
        ]  # A list of cnots at each time slice

        return n_qubits, mapping, scheduling


# Paper ------------------------------------------------------------------------


class EDPC(Strategy):
    def compile(self):
        n_qubits, mapping, graph = self.__build_operator_graph()

        q1 = self.__construct_edp(mapping, graph)

        q2 = []
        while self._cnots:
            terminals, p = self.__greedy_edp()
            self._cnots = [cnot for cnot in self._cnots if cnot not in terminals]
            q2 += p

        scheduling = q1 if len(q1) < len(q2) else q2

        return n_qubits, mapping, scheduling

    def __build_operator_graph(
        self,
    ) -> tuple[int, dict[int, int], OperatorGraph]:
        if self._grid_dims[0] % 2 == 0:
            self._grid_dims = (self._grid_dims[0] - 1, self._grid_dims[1])

        if self._grid_dims[1] % 2 == 0:
            self._grid_dims = (self._grid_dims[0], self._grid_dims[1] - 1)

        n_data_max = (self._grid_dims[0] // 2) * (self._grid_dims[1] // 2)

        data_mapping = {}
        used_indices = set()
        n_data_qubits = 0

        for cnot in self._cnots:
            for qubit in cnot:
                if qubit not in used_indices:
                    used_indices.add(n_data_qubits)
                    data_mapping[n_data_qubits] = qubit
                    n_data_qubits += 1

                    if n_data_qubits > n_data_max:
                        raise ValueError(
                            f"The input circuit is not mappable to the given grid dimension {self._grid_dims}."
                        )

        mapping = {}
        current_index = 0

        for i, j in itertools.product(
            range(self._grid_dims[0]), range(self._grid_dims[1])
        ):
            if i % 2 == 1 and j % 2 == 1 and current_index < n_data_qubits:
                mapping[data_mapping[current_index]] = flatten(i, j, self._grid_dims)
                current_index += 1

        n_qubits = np.prod(self._grid_dims)

        graph = OperatorGraph(self._grid_dims)

        return n_qubits, mapping, graph

    def __construct_edp(
        self, mapping: dict[int, int], graph: OperatorGraph
    ) -> list[list[tuple[int, int]]]:
        paths = graph.build_paths(mapping, self._cnots)

        return paths

    def __edp_subroutine(self) -> list[list[tuple[int, int]]]:
        return []

    def __greedy_edp(self) -> tuple[list[tuple[int, int]], list[list[tuple[int, int]]]]:
        return [], []
