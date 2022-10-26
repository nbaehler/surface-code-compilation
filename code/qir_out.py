from pyqir.generator import BasicQisBuilder, SimpleModule


def generate_qir(
    n_qubits: int, mapping: dict[int, int], scheduling: list[list[tuple[int, int]]]
):
    module = SimpleModule(
        "Output", num_qubits=n_qubits, num_results=n_qubits
    )  # Num results needed?

    qis = BasicQisBuilder(module.builder)

    for time_slice in scheduling:
        for cnot in time_slice:
            qis.cx(module.qubits[mapping[cnot[0]]], module.qubits[mapping[cnot[1]]])

    return module.ir()
