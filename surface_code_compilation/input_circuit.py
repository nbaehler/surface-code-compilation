import numpy as np
from pyqir import (
    BasicQisBuilder,
    SimpleModule,
)

from helpers import flatten


def input_circuit() -> tuple[SimpleModule, tuple[int, int]]:
    # Fix the grid dimensions and hence number of qubits
    grid_dims = (9, 9)
    n_qubits = int(np.prod(grid_dims))

    # Create the module
    mod = SimpleModule("input", num_qubits=n_qubits, num_results=n_qubits)
    qis = BasicQisBuilder(mod.builder)

    # Add instructions to the module
    qis.cx(mod.qubits[flatten(7, 3, grid_dims)], mod.qubits[flatten(1, 1, grid_dims)])
    qis.cx(mod.qubits[flatten(5, 1, grid_dims)], mod.qubits[flatten(3, 1, grid_dims)])
    qis.cx(mod.qubits[flatten(1, 5, grid_dims)], mod.qubits[flatten(5, 3, grid_dims)])
    qis.cx(mod.qubits[flatten(1, 7, grid_dims)], mod.qubits[flatten(1, 3, grid_dims)])
    qis.cx(mod.qubits[flatten(5, 7, grid_dims)], mod.qubits[flatten(5, 5, grid_dims)])

    return mod, grid_dims
