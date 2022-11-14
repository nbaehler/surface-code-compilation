from abc import ABC


class Gate(ABC):
    pass


class CNOT(Gate):  # TODO add all gates that I need
    def __init__(self, control: int, target: int) -> None:
        super().__init__()
        self._control = control
        self._target = target
