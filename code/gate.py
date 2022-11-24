from abc import ABC

# Class modeling gates in the intermediate representation
class Gate(ABC):
    pass


# CNOT gate in the intermediate representation
class CNOT(Gate):  # TODO add all gates that I need
    def __init__(self, control: int, target: int) -> None:
        super().__init__()
        self._control = control
        self._target = target
