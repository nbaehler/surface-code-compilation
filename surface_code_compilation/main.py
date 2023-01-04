import tempfile

from compiler import Compiler
from input_circuit import input_circuit
from mapper import Identity, PaperIdentity, PaperRenaming, Renaming
from qir_generator import generate_qir
from qir_parser import parse_qir
from scheduler import EDPC, Sequential


def main():
    # Generated circuit using the QIR-Alliance generator
    in_circ, grid_dims = input_circuit()
    # in_circ, grid_dims = input_circuit2()
    in_qir = in_circ.ir()

    # Write temporary llvm file so that the parser can read it
    with tempfile.NamedTemporaryFile(
        suffix=".ll"
    ) as f:  # https://github.com/qir-alliance/pyqir/blob/a99afdb8126b1ff0a331bdc81aed9930f7bd23b9/examples/evaluator/teleport.py#L36-L40
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
    (n_qubits, mapping, grid_dims) = mapping_strategy(
        grid_dims, cnots
    ).map()  # TODO do I need those abstract classes?

    print(f"Number of qubits used: {n_qubits}")
    print(f"Mapping of qubits: {mapping}")

    # Schedule the CNOTs according to strategy
    scheduling = scheduling_strategy(
        grid_dims, cnots, mapping
    ).schedule()  # TODO do I need those abstract classes?

    scheduling_str = ",\n".join(
        [", ".join([str(path) for path in phase]) for phase in scheduling]
    )
    print(f"Scheduling:\n[{scheduling_str}]\n")

    # Compile the scheduled CNOTs into a intermediate representation
    ir = Compiler(
        mapping, scheduling
    ).compile()  # TODO do I need those abstract classes?

    # Generate QIR from intermediate representation
    res_qir = generate_qir(n_qubits, ir)

    print(f"The resulting QIR code:\n{res_qir}")


if __name__ == "__main__":
    main()
