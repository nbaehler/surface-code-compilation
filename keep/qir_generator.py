from gate import Gate
from pyqir import BasicQisBuilder, SimpleModule


# Given the ir of the circuit, generate the corresponding qir
def generate_qir(n_qubits: int, ir: list[list[Gate]]):
    module = SimpleModule("Output", num_qubits=n_qubits, num_results=n_qubits)

    qis = BasicQisBuilder(module.builder)

    # TODO: Implement this
    for phase in ir:  # TODO adapt to compiler
        for gate in phase:
            pass
            # qis.cx(module.qubits[mapping[cnot[0]]], module.qubits[mapping[cnot[1]]])

    return module.ir()
