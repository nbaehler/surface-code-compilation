from compiler import Compiler
from input_circuit import input_circuit
from mapper import Identity, PaperIdentity, PaperRenaming, Renaming
from qir_parser import parse_qir
from scheduler import EDPC, Sequential
from visualizer import Visualizer


def main():
    # Generated circuit using the QIR-Alliance generator
    in_circ, grid_dims = input_circuit()
    in_qir = in_circ.ir()

    # Write llvm file so that the parser can read it
    with open("input.ll", "wb") as f:
        f.write(in_qir.encode("utf-8"))
        f.flush()
        cnots = parse_qir(f.name)

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
    print(f"Scheduling:\n[{scheduling_str}]\n")

    # Visualize the scheduling
    Visualizer(grid_dims, scheduling).visualize()

    # Compile the scheduled CNOTs into QIR
    out_qir = Compiler(grid_dims, scheduling).compile()

    print(f"The resulting QIR code:\n{out_qir}")

    with open("output.ll", "wb") as f:
        f.write(out_qir.encode("utf-8"))
        f.flush()


if __name__ == "__main__":
    main()
