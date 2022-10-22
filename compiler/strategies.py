import numpy as np
from abc import ABC, abstractmethod


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


class Sequential2(Strategy):
    def compile(self):
        n_max = np.prod(self._grid_dims)
        mapping = {}
        used_indices = set()
        current_index = 0

        for cnot in self._cnots:
            for qubit in cnot:
                if qubit not in used_indices:
                    used_indices.add(current_index)
                    mapping[qubit] = current_index
                    current_index += 1

                    if current_index == n_max:
                        raise ValueError(
                            f"The input circuit is not mappable to the given grid dimension {self._grid_dims}."
                        )

        scheduling = [
            [cnot] for cnot in self._cnots
        ]  # A list of cnots at each time slice

        return current_index, mapping, scheduling


# Paper ------------------------------------------------------------------------


class EDPC(Strategy):
    def compile(self):
        if self._grid_dims[0] % 2 == 0:
            self._grid_dims = (self._grid_dims[0] - 1, self._grid_dims[1])

        if self._grid_dims[1] % 2 == 0:
            self._grid_dims = (self._grid_dims[0], self._grid_dims[1] - 1)

        n_qubits = np.prod(self._grid_dims)
        mapping = {i: i for i in range(n_qubits)}

        q1 = self.__edp_subroutine()

        q2 = []
        while self._cnots:
            terminals, p = self.__greedy_edp()
            self._cnots = [cnot for cnot in self._cnots if cnot not in terminals]
            q2 += p

        scheduling = q1 if len(q1) < len(q2) else q2

        return n_qubits, mapping, scheduling

    def __edp_subroutine(self) -> list[list[tuple[int, int]]]:
        return []

    def __greedy_edp(self) -> tuple[list[tuple[int, int]], list[list[tuple[int, int]]]]:
        return [], []
