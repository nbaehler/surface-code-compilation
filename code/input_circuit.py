import numpy as np
from pyqir.generator import BasicQisBuilder, SimpleModule


def input_circuit() -> tuple[SimpleModule, tuple[int, int]]:
    # Fix the grid dimensions and hence number of qubits
    grid_dims = (6, 6)
    n_qubits = int(np.prod(grid_dims))

    # Create the module
    in_circ = SimpleModule("input_circuit", num_qubits=n_qubits, num_results=n_qubits)
    qis = BasicQisBuilder(in_circ.builder)

    # Add instructions to the module
    # qis.cx(in_circ.qubits[0], in_circ.qubits[1])
    # qis.cx(in_circ.qubits[2], in_circ.qubits[3])
    # qis.cx(in_circ.qubits[0], in_circ.qubits[1])

    # qis.cx(in_circ.qubits[6], in_circ.qubits[8])
    # qis.cx(in_circ.qubits[16], in_circ.qubits[18])
    # qis.cx(in_circ.qubits[6], in_circ.qubits[8])

    # qis.cx(in_circ.qubits[0], in_circ.qubits[1])
    # qis.cx(in_circ.qubits[2], in_circ.qubits[3])
    # qis.cx(
    #     in_circ.qubits[0], in_circ.qubits[3]
    # )

    qis.cx(in_circ.qubits[6], in_circ.qubits[18])  # TODO error
    qis.cx(in_circ.qubits[16], in_circ.qubits[8])

    return in_circ, grid_dims
