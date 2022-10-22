from pyqir.generator import BasicQisBuilder, SimpleModule


def generate_qir(mapping, schedule):
    module = SimpleModule(
        "Output", num_qubits=mapping.size, num_results=mapping.size
    )  # Num results needed?

    qis = BasicQisBuilder(module.builder)

    for time_slice in schedule:
        for cnot in time_slice:
            qis.cx(module.qubits[mapping[cnot[0]]], module.qubits[mapping[cnot[1]]])

    return module.ir()
