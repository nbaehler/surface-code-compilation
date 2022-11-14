from pyqir.generator import BasicQisBuilder, SimpleModule

from gate import Gate


def generate_qir(n_qubits: int, ir: list[list[Gate]]):
    module = SimpleModule(
        "Output", num_qubits=n_qubits, num_results=n_qubits
    )  # Num results needed?

    qis = BasicQisBuilder(module.builder)

    for phase in ir:  # TODO adapt to compiler
        for gate in phase:
            pass
            # qis.cx(module.qubits[mapping[cnot[0]]], module.qubits[mapping[cnot[1]]])

    return module.ir()
