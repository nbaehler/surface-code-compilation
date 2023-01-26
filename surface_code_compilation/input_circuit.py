import numpy as np
from pyqir import BasicQisBuilder, SimpleModule


def input_circuit() -> tuple[SimpleModule, tuple[int, int]]:
    # Fix the grid dimensions and hence number of qubits
    grid_dims = (6, 6)
    n_qubits = int(np.prod(grid_dims))

    # Create the module
    mod = SimpleModule("input", num_qubits=n_qubits, num_results=n_qubits)
    qis = BasicQisBuilder(mod.builder)

    # Add instructions to the module
    # qis.cx(mod.qubits[0], mod.qubits[1])
    # qis.cx(mod.qubits[2], mod.qubits[3])
    # qis.cx(mod.qubits[0], mod.qubits[1])

    # qis.cx(mod.qubits[6], mod.qubits[8])
    # qis.cx(mod.qubits[16], mod.qubits[18])
    # qis.cx(mod.qubits[6], mod.qubits[8])

    # qis.cx(mod.qubits[0], mod.qubits[1])
    # qis.cx(mod.qubits[2], mod.qubits[3])
    # qis.cx(
    #     mod.qubits[0], mod.qubits[3]
    # )

    qis.cx(mod.qubits[6], mod.qubits[18])
    qis.cx(mod.qubits[16], mod.qubits[8])

    return mod, grid_dims
