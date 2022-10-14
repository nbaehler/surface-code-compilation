from pyqir.evaluator import NonadaptiveEvaluator, GateSet
from typing import Any, Dict, List, Tuple


class Logger(GateSet):
    number_of_qubits: int
    number_of_registers: int
    instructions: List[Tuple[int, int]]

    def __init__(self) -> None:
        self.number_of_qubits = 0
        self.number_of_registers = 0
        self.instructions = []

    def cx(self, control: str, target: str) -> None:
        self.instructions.append((int(control), int(target)))

    def cz(self, control: str, target: str) -> None:
        # self.instructions.append(f"cz qubit[{control}], qubit[{target}]")
        pass

    def h(self, target: str) -> None:
        # self.instructions.append(f"h qubit[{target}]")
        pass

    def m(self, qubit: str, target: str) -> None:
        # self.instructions.append(f"m qubit[{qubit}] => out[{target}]")
        pass

    def mz(self, qubit: str, target: str) -> None:
        # self.instructions.append(f"m qubit[{qubit}] => out[{target}]")
        pass

    def reset(self, target: str) -> None:
        # self.instructions.append(f"reset {target}")
        pass

    def rx(self, theta: float, qubit: str) -> None:
        # self.instructions.append(f"rx theta[{theta}] qubit[{qubit}]")
        pass

    def ry(self, theta: float, qubit: str) -> None:
        # self.instructions.append(f"ry theta[{theta}] qubit[{qubit}]")
        pass

    def rz(self, theta: float, qubit: str) -> None:
        # self.instructions.append(f"rz theta[{theta}] qubit[{qubit}]")
        pass

    def s(self, qubit: str) -> None:
        # self.instructions.append(f"s qubit[{qubit}]")
        pass

    def s_adj(self, qubit: str) -> None:
        # self.instructions.append(f"s_adj qubit[{qubit}]")
        pass

    def t(self, qubit: str) -> None:
        # self.instructions.append(f"t qubit[{qubit}]")
        pass

    def t_adj(self, qubit: str) -> None:
        # self.instructions.append(f"t_adj qubit[{qubit}]")
        pass

    def x(self, qubit: str) -> None:
        # self.instructions.append(f"x qubit[{qubit}]")
        pass

    def y(self, qubit: str) -> None:
        # self.instructions.append(f"y qubit[{qubit}]")
        pass

    def z(self, qubit: str) -> None:
        # self.instructions.append(f"z qubit[{qubit}]")
        pass

    def finish(self, metadata: Dict[str, Any]) -> None:
        super().finish(metadata)
        self.number_of_qubits = metadata["number_of_qubits"]
        self.number_of_registers = self.number_of_qubits

    def print(self) -> None:
        print(f"qubits[{self.number_of_qubits}]")
        print(f"out[{self.number_of_registers}]")

        for instruction in self.instructions:
            print(instruction)


def logGates(file):
    evaluator = NonadaptiveEvaluator()
    logger = Logger()

    evaluator.eval(file, logger)

    return logger.instructions
