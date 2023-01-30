import itertools
from abc import ABC, abstractmethod

import numpy as np
from helpers import flatten, is_data_qubit, unflatten


# Class that defines the interface of different mappers/mapping strategies for a
# set qubits to a grid
class Mapper(ABC):
    def __init__(
        self, grid_dims: tuple[int, int], cnots: list[tuple[int, int]]
    ) -> None:
        super().__init__()

        self._grid_dims: tuple[int, int] = grid_dims
        self._cnots: list[tuple[int, int]] = cnots

    @abstractmethod
    def map(self) -> tuple[int, dict[int, int], tuple[int, int]]:
        pass


# Use identity mapping and simply check that the mapping is valid with the given
# grid dimension
class Identity(Mapper):
    def map(self):
        n_qubits = int(np.prod(self._grid_dims))

        # Compute mapping
        mapping = {}
        for cnot in self._cnots:
            for qubit in cnot:
                if qubit not in mapping.keys():
                    # Check that index is not out of bounds
                    if qubit >= n_qubits:
                        raise ValueError(
                            f"The input circuit is not mappable to the given grid dimension {self._grid_dims}."
                        )

                    # Identity mapping
                    mapping[qubit] = qubit

        return n_qubits, mapping, self._grid_dims


# Rename the indices of the qubits in order to use the smallest indices possible
class Renaming(Mapper):
    def map(self):
        n_max = np.prod(self._grid_dims)
        mapping = {}
        n_qubits = 0

        # Compute mapping
        for cnot in self._cnots:
            for qubit in cnot:
                if qubit not in mapping.keys():
                    mapping[qubit] = n_qubits
                    n_qubits += 1

                    # Check that index is not out of bounds
                    if n_qubits > n_max:
                        raise ValueError(
                            f"The input circuit is not mappable to the given grid dimension {self._grid_dims}."
                        )

        return n_qubits, mapping, self._grid_dims


def _check_grid_dimensions(grid_dims: tuple[int, int]) -> tuple[tuple[int, int], int]:
    # Make sure that the grid dimensions are odd
    if grid_dims[0] % 2 == 0:
        grid_dims = (grid_dims[0] - 1, grid_dims[1])

    if grid_dims[1] % 2 == 0:
        grid_dims = (grid_dims[0], grid_dims[1] - 1)

    # Compute number of qubits
    n_qubits = int(np.prod(grid_dims))

    return grid_dims, n_qubits


class PaperIdentity(Mapper):
    def map(
        self,
    ):
        # Make sure that the grid dimensions are odd
        self._grid_dims, n_qubits = _check_grid_dimensions(self._grid_dims)

        n_qubits = int(np.prod(self._grid_dims))

        # Compute mapping
        mapping = {}
        for cnot in self._cnots:
            for qubit in cnot:
                if qubit not in mapping.keys():
                    # Check that index is not out of bounds and that the qubit is a data qubit
                    if qubit >= n_qubits or not is_data_qubit(
                        unflatten(qubit, self._grid_dims)
                    ):
                        raise ValueError(
                            f"The input circuit is not mappable to the given grid dimension {self._grid_dims}."
                        )

                    # Identity mapping
                    mapping[qubit] = qubit

        return n_qubits, mapping, self._grid_dims


class PaperRenaming(Mapper):
    def map(
        self,
    ):
        # Make sure that the grid dimensions are odd
        self._grid_dims, n_qubits = _check_grid_dimensions(self._grid_dims)

        # Compute intermediate mapping
        n_data_max = (self._grid_dims[0] // 2) * (self._grid_dims[1] // 2)
        data_mapping = {}
        n_data_qubits = 0
        for cnot in self._cnots:
            for qubit in cnot:
                if qubit not in data_mapping.values():
                    data_mapping[n_data_qubits] = qubit
                    n_data_qubits += 1

                    # Check that index is not out of bounds
                    if n_data_qubits > n_data_max:
                        raise ValueError(
                            f"The input circuit is not mappable to the given grid dimension {self._grid_dims}."
                        )

        # Compute mapping
        mapping = {}
        current_index = 0
        for r, c in itertools.product(
            range(1, self._grid_dims[0], 2), range(1, self._grid_dims[1], 2)
        ):
            if current_index >= n_data_qubits:
                break

            assert is_data_qubit((r, c))
            mapping[data_mapping[current_index]] = flatten(r, c, self._grid_dims)
            current_index += 1

        return n_qubits, mapping, self._grid_dims
