import numpy as np


def check(cnot, mapping, schedule):  # TODO remove
    control = mapping[cnot[0]]
    target = mapping[cnot[1]]

    mapping_2D = np.reshape(mapping, (-1, 2))

    # TODO Is there a greedy algorithm?
    # Check if path is clear, change mapping, change schedule

    return True


def sequential(grid_dims, cnots):
    n_qubits = grid_dims[0] * grid_dims[1]
    mapping = np.array(range(n_qubits))
    schedule = [[cnot] for cnot in cnots]  # A list of cnots at each time slice

    return mapping, schedule
