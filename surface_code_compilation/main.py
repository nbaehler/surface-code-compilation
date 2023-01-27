import os
import tempfile

from compiler import Compiler
from helpers import make_runnable
from input_circuit import input_circuit
from mapper import Identity, PaperIdentity, PaperRenaming, Renaming
from qir_parser import parse_qir
from scheduler import EDPC, Sequential
from visualizer import Visualizer


def main():
    # Generated circuit using the QIR-Alliance generator
    mod, grid_dims = input_circuit()

    root_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")

    # Write temporary llvm file so that the parser can read it
    with tempfile.NamedTemporaryFile(
        suffix=".ll"
    ) as f:  # https://github.com/qir-alliance/pyqir/blob/a99afdb8126b1ff0a331bdc81aed9930f7bd23b9/examples/evaluator/teleport.py#L36-L40
        f.write(mod.ir().encode("utf-8"))
        f.flush()
        cnots = parse_qir(f.name)

    make_runnable(mod)

    # Write llvm file that can be run by the qir-runner
    with open(os.path.join(root_dir, "input.ll"), "wb") as f:
        f.write(mod.ir().encode("utf-8"))
        f.flush()

    # Select strategies
    # mapping_strategy, scheduling_strategy = Identity, Sequential
    # mapping_strategy, scheduling_strategy = Renaming, Sequential
    mapping_strategy, scheduling_strategy = PaperIdentity, EDPC
    # mapping_strategy, scheduling_strategy = PaperRenaming, EDPC

    print("Infos:")

    # Map the qubits according to strategy
    (n_qubits, mapping, grid_dims) = mapping_strategy(grid_dims, cnots).map()

    print(f"Number of qubits used: {n_qubits}")
    print(f"Mapping of qubits: {mapping}")

    # Schedule the CNOTs according to strategy
    scheduling = scheduling_strategy(grid_dims, cnots, mapping).schedule()

    scheduling_str = ",\n".join(
        [", ".join([str(path) for path in phase]) for phase in scheduling]
    )
    print(f"Scheduling: [{scheduling_str}]")

    # Compile the scheduled CNOTs into QIR
    out_qir = Compiler(grid_dims, scheduling).compile()

    # Write the output QIR
    with open(os.path.join(root_dir, "output.ll"), "wb") as f:
        f.write(out_qir.encode("utf-8"))
        f.flush()

    # Visualize the scheduling
    Visualizer(grid_dims, scheduling).visualize()


if __name__ == "__main__":
    main()
