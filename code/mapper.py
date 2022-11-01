import itertools
from abc import ABC, abstractmethod

import numpy as np

from helpers import flatten, is_data_qubit


class Mapper(ABC):
    def __init__(
        self, grid_dims: tuple[int, int], cnots: list[tuple[int, int]]
    ) -> None:
        super().__init__()

        self._grid_dims: tuple[int, int] = grid_dims
        self._cnots: list[tuple[int, int]] = cnots

    @abstractmethod
    def map(self) -> tuple[int, dict[int, int]]:
        pass


# Dummy ------------------------------------------------------------------------


class Identity(Mapper):
    def map(self):
        n_qubits = int(np.prod(self._grid_dims))

        if not self.__mappable(self._cnots, n_qubits):
            raise ValueError(
                f"The input circuit is not mappable to the given grid dimension {self._grid_dims}."
            )

        mapping = {i: i for i in range(n_qubits)}

        return n_qubits, mapping

    def __mappable(self, cnots: list[tuple[int, int]], n_qubits: int):
        return not any(cnot[0] >= n_qubits or cnot[1] >= n_qubits for cnot in cnots)


class SimpleRenaming(Mapper):
    def map(self):
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

        return n_qubits, mapping


# Paper ------------------------------------------------------------------------


class Grid(Mapper):
    def map(self):
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

        for r, c in itertools.product(
            range(self._grid_dims[0]), range(self._grid_dims[1])
        ):
            if is_data_qubit((r, c)) and current_index < n_data_qubits:
                mapping[data_mapping[current_index]] = flatten(r, c, self._grid_dims)
                current_index += 1

        n_qubits = int(np.prod(self._grid_dims))

        return n_qubits, mapping, self._grid_dims
