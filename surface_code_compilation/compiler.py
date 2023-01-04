from gate import Gate
from helpers import is_data_qubit
from path import Path


# Class the compiles a scheduling into a intermediate representation using a
# mapping as well
class Compiler:
    def __init__(self, mapping: dict[int, int], scheduling: list[list[Path]]) -> None:
        self._mapping: dict[int, int] = mapping
        self._scheduling: list[list[Path]] = scheduling

    # Compile into the intermediate representation
    def compile(self) -> list[list[Gate]]:
        ir = []
        for phase in self._scheduling:
            phase_ir = []
            for path in phase:
                if is_data_qubit(path[0]):
                    if is_data_qubit(path[-1]):
                        phase_ir.append(self._compile_long_range_cnot(path))
                    else:
                        phase_ir.append(self._compile_control_to_ancilla(path))
                elif is_data_qubit(path[-1]):
                    phase_ir.append(self._compile_ancilla_to_target(path))
                else:
                    phase_ir.append(self._compile_ancilla_to_ancilla(path))
            ir.append(phase_ir)

        return ir

    def _compile_long_range_cnot(self, path: Path) -> list[Gate]:
        return []

    def _compile_control_to_ancilla(self, path: Path) -> list[Gate]:
        return []

    def _compile_ancilla_to_target(self, path: Path) -> list[Gate]:
        return []

    def _compile_ancilla_to_ancilla(self, path: Path) -> list[Gate]:
        return []
