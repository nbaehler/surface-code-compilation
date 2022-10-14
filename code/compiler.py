import os
from pathlib import Path
import tempfile
import numpy as np

from evaluator import logGates
from generator import generate_qir

import qsharp

from Circuits import testCircuit


def main():
    in_qir = testCircuit.as_qir()

    with tempfile.NamedTemporaryFile(
        suffix=".ll"
    ) as f:  # https://github.com/qir-alliance/pyqir/blob/a99afdb8126b1ff0a331bdc81aed9930f7bd23b9/examples/evaluator/teleport.py#L36-L40
        f.write(in_qir.encode("utf-8"))
        f.flush()
        cnots = logGates(f.name)

    # -------------------------------

    # in_qir = testCircuit.as_qir()

    # with open("temp.ll", "w") as f:
    #     f.writelines(in_qir)

    # os.system("llvm-as temp.ll")

    # cnots = logGates("temp.bc")

    # os.remove("temp.ll")
    # os.remove("temp.bc")

    # -------------------------------

    # path = Path(__file__).parent
    # file_path = os.path.join(path, "bernstein_vazirani.bc")

    # cnots = logGates(file_path)

    # -------------------------------

    # cnots = [(0, 1), (15, 1)]

    # -------------------------------

    grid_dims = (4, 5)

    if not valid(cnots, np.prod(grid_dims)):
        raise ValueError("The input circuit is invalid.")

    mapping, scheduling = compile_dummy(grid_dims, cnots)
    return generate_qir(mapping, scheduling)


def compile_dummy(grid_dims, cnots):
    n_qubits = grid_dims[0] * grid_dims[1]
    mapping = np.array(range(n_qubits))
    schedule = [[cnot] for cnot in cnots]  # A list of cnots at each time slice

    return mapping, schedule


def valid(cnots, n_qubits):
    return not any(cnot[0] >= n_qubits or cnot[1] >= n_qubits for cnot in cnots)


def check(cnot, mapping, schedule):
    control = mapping[cnot[0]]
    target = mapping[cnot[1]]

    mapping_2D = np.reshape(mapping, (-1, 2))

    # Is there a greedy algorithm?
    # Check if path is clear, change mapping, change schedule

    return True


if __name__ == "__main__":
    res_qir = main()

    print(res_qir)
