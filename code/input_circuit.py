import numpy as np
from pyqir.generator import BasicQisBuilder, SimpleModule


def input_circuit() -> tuple[SimpleModule, tuple[int, int]]:
    # Fix the grid dimensions and select strategies
    grid_dims = (6, 6)

    n_qubits = int(np.prod(grid_dims))

    # Create the module
    in_circ = SimpleModule("input_circuit", num_qubits=n_qubits, num_results=n_qubits)
    qis = BasicQisBuilder(in_circ.builder)

    # Add instructions to the module
    qis.h(in_circ.qubits[0])

    qis.cx(in_circ.qubits[0], in_circ.qubits[1])
    qis.cx(in_circ.qubits[2], in_circ.qubits[3])
    qis.cx(in_circ.qubits[0], in_circ.qubits[1])

    qis.mz(in_circ.qubits[0], in_circ.results[0])
    qis.mz(in_circ.qubits[1], in_circ.results[1])

    return in_circ, grid_dims
