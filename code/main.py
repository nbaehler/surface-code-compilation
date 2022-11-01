import os
import tempfile
from pathlib import Path

import qsharp

from compiler import compile
from mapper import Grid, Identity, SimpleRenaming
from qir_in import log_gates
from qir_out import generate_qir
from scheduler import EDPC, Sequential

# from Circuits import testCircuit


def main():
    # in_qir = testCircuit.as_qir()

    # with tempfile.NamedTemporaryFile(  # TODO Problem: https://github.com/qir-alliance/pyqir/tree/main/pyqir-evaluator#pyqir-evaluator
    #     suffix=".ll"
    # ) as f:  # https://github.com/qir-alliance/pyqir/blob/a99afdb8126b1ff0a331bdc81aed9930f7bd23b9/examples/evaluator/teleport.py#L36-L40
    #     f.write(in_qir.encode("utf-8"))
    #     f.flush()
    #     cnots = log_gates(f.name)

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
    # file_path = os.path.join(path, "bitcode/bernstein_vazirani.bc")

    # cnots = logGates(file_path)

    # -------------------------------

    cnots = [(0, 1), (15, 1)]

    # -------------------------------

    grid_dims = (6, 6)

    (
        n_qubits,
        mapping,
        grid_dims,
    ) = Grid(  # TODO grid is the only one the change grid dims?
        grid_dims, cnots
    ).map()  # TODO do I need those abstract classes?

    scheduling = EDPC(grid_dims, cnots, mapping).schedule()

    ir = compile(mapping, scheduling)  # TODO input to generator

    print("\nInfos:")
    print(f"Number of qubits used: {n_qubits}")
    print(f"Mapping of qubits: {mapping}")
    print(f"Scheduling: {scheduling}\n")

    res_qir = generate_qir(n_qubits, mapping, scheduling)

    print(f"The resulting QIR code:\n{res_qir}")


if __name__ == "__main__":
    main()

# TODO
# Mapper, mapping strategy
# Scheduler, scheduling strategy
# Compiler, compiling strategy
