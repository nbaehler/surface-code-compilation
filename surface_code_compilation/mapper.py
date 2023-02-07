import itertools
from abc import ABC, abstractmethod

import numpy as np
from helpers import is_data_qubit, unflatten


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
    def map(self) -> tuple[int, dict[int, tuple[int, int]], tuple[int, int]]:
        pass


# Helper function to fixes the grid dimensions to be odd
def _fix_grid_dimensions(grid_dims: tuple[int, int]) -> tuple[tuple[int, int], int]:
    # Make sure that the grid dimensions are odd
    if grid_dims[0] % 2 == 0:
        grid_dims = (grid_dims[0] - 1, grid_dims[1])

    if grid_dims[1] % 2 == 0:
        grid_dims = (grid_dims[0], grid_dims[1] - 1)

    # Compute number of qubits
    n_qubits = int(np.prod(grid_dims))

    return grid_dims, n_qubits


# Class that implements the identity mapping strategy
class Identity(Mapper):
    def map(
        self,
    ):
        # Make sure that the grid dimensions are odd
        self._grid_dims, n_qubits = _fix_grid_dimensions(self._grid_dims)

        n_qubits = int(np.prod(self._grid_dims))

        # Compute mapping
        mapping = {}
        for cnot in self._cnots:
            for qubit in cnot:
                if qubit not in mapping.keys():
                    pos = unflatten(qubit, self._grid_dims)

                    # Check that index is not out of bounds and that the qubit is a data qubit
                    if qubit >= n_qubits or not is_data_qubit(pos):
                        raise ValueError(
                            f"The input circuit is not mappable to the given grid dimension {self._grid_dims}."
                        )

                    # Identity mapping
                    mapping[qubit] = pos

        return n_qubits, mapping, self._grid_dims


# Class that implements the renaming mapping strategy, which just renames the
# qubits to use the smallest indices possible
class Renaming(Mapper):
    def map(
        self,
    ):
        # Make sure that the grid dimensions are odd
        self._grid_dims, n_qubits = _fix_grid_dimensions(self._grid_dims)

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
            mapping[data_mapping[current_index]] = (r, c)
            current_index += 1

        return n_qubits, mapping, self._grid_dims
