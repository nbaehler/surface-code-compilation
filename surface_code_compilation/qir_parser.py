from pyqir.evaluator import GateSet, NonadaptiveEvaluator


# Logger for all the instructions that are important for us, so far only cnots
class Logger(GateSet):
    def __init__(self) -> None:
        self.number_of_qubits: int = 0
        self.number_of_registers: int = 0
        self.instructions: list[tuple[int, int]] = []

    def cx(self, control: str, target: str) -> None:
        self.instructions.append((int(control), int(target)))

    def cz(self, control: str, target: str) -> None:
        print(f" Ignored: cz qubit[{control}], qubit[{target}]")

    def h(self, target: str) -> None:
        print(f" Ignored: h qubit[{target}]")

    def m(self, qubit: str, target: str) -> None:
        print(f" Ignored: m qubit[{qubit}] => out[{target}]")

    def mz(self, qubit: str, target: str) -> None:
        print(f" Ignored: m qubit[{qubit}] => out[{target}]")

    def reset(self, target: str) -> None:
        print(f" Ignored: reset {target}")

    def rx(self, theta: float, qubit: str) -> None:
        print(f" Ignored: rx theta[{theta}] qubit[{qubit}]")

    def ry(self, theta: float, qubit: str) -> None:
        print(f" Ignored: ry theta[{theta}] qubit[{qubit}]")

    def rz(self, theta: float, qubit: str) -> None:
        print(f" Ignored: rz theta[{theta}] qubit[{qubit}]")

    def s(self, qubit: str) -> None:
        print(f" Ignored: s qubit[{qubit}]")

    def s_adj(self, qubit: str) -> None:
        print(f" Ignored: s_adj qubit[{qubit}]")

    def t(self, qubit: str) -> None:
        print(f" Ignored: t qubit[{qubit}]")

    def t_adj(self, qubit: str) -> None:
        print(f" Ignored: t_adj qubit[{qubit}]")

    def x(self, qubit: str) -> None:
        print(f" Ignored: x qubit[{qubit}]")

    def y(self, qubit: str) -> None:
        print(f" Ignored: y qubit[{qubit}]")

    def z(self, qubit: str) -> None:
        print(f" Ignored: z qubit[{qubit}]")


# Parse the qir file and log all the cnots
def parse_qir(file: str):
    evaluator = (
        NonadaptiveEvaluator()
    )  # TODO not complete syntax https://github.com/qir-alliance/pyqir/tree/main/pyqir-evaluator#pyqir-evaluator
    logger = Logger()

    evaluator.eval(file, logger)

    return logger.instructions
