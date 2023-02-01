from abc import ABC
from enum import Enum

from helpers import unflatten
from pyqir import BasicQisBuilder, SimpleModule


# Enum modeling the orientation of double qubit gates
class Orientation(Enum):
    HORIZONTAL = 0
    VERTICAL = 1


# Class modeling gates
class Gate(ABC):
    def __init__(self) -> None:
        super().__init__()


# Class modeling single qubit gates
class SingleQubitGate(Gate):
    def __init__(self) -> None:
        super().__init__()


# Class modeling double qubit gates
class DoubleQubitGate(Gate):
    def __init__(
        self,
        q1: int,
        q2: int,
        grid_dims: tuple[int, int],
        orientation: Orientation = None,
    ) -> None:
        super().__init__()

        # Set the orientation
        p1 = unflatten(q1, grid_dims)
        p2 = unflatten(q2, grid_dims)

        self._orientation = (
            Orientation.HORIZONTAL if p1[0] == p2[0] else Orientation.VERTICAL
        )

        # Check if the given orientation is correct
        if orientation is not None:
            assert self._orientation == orientation


# Class modeling Z gates
class Z(SingleQubitGate):
    def __init__(self, mod: SimpleModule, qis: BasicQisBuilder, q: int) -> None:
        super().__init__()

        qis.z(mod.qubits[q])


# Class modeling X gates
class X(SingleQubitGate):
    def __init__(self, mod: SimpleModule, qis: BasicQisBuilder, q: int) -> None:
        super().__init__()

        qis.x(mod.qubits[q])


# Class modeling the preparation of X states
class PrepareX(SingleQubitGate):
    def __init__(self, mod: SimpleModule, qis: BasicQisBuilder, q: int) -> None:
        super().__init__()

        qis.reset(mod.qubits[q])
        qis.h(mod.qubits[q])


# Class modeling the preparation of Z states
class PrepareZ(SingleQubitGate):
    def __init__(self, mod: SimpleModule, qis: BasicQisBuilder, q: int) -> None:
        super().__init__()

        qis.reset(mod.qubits[q])


# Class modeling the preparation of Bell states
class PrepareBB(DoubleQubitGate):
    def __init__(
        self,
        mod: SimpleModule,
        qis: BasicQisBuilder,
        q1: int,
        q2: int,
        q_ancilla: int,
        grid_dims: tuple[int, int],
    ) -> None:
        super().__init__(q1, q2, grid_dims)

        if self._orientation == Orientation.HORIZONTAL:
            PrepareZ(mod, qis, q1)
            PrepareZ(mod, qis, q2)

            MeasureXX(mod, qis, q1, q2, q_ancilla, grid_dims)

            qis.if_result(mod.results[q_ancilla], lambda: Z(mod, qis, q2))

        else:  # Vertical
            PrepareX(mod, qis, q1)
            PrepareX(mod, qis, q2)

            MeasureZZ(mod, qis, q1, q2, q_ancilla, grid_dims)

            qis.if_result(mod.results[q_ancilla], lambda: X(mod, qis, q2))


# Class modeling Z measurements
class MeasureZ(SingleQubitGate):
    def __init__(
        self, mod: SimpleModule, qis: BasicQisBuilder, q: int, r: int = None
    ) -> None:
        super().__init__()

        if r is None:
            r = q

        qis.mz(mod.qubits[q], mod.results[r])


# Class modeling X measurements
class MeasureX(SingleQubitGate):
    def __init__(
        self, mod: SimpleModule, qis: BasicQisBuilder, q: int, r: int = None
    ) -> None:
        super().__init__()

        if r is None:
            r = q

        qis.h(mod.qubits[q])
        qis.mz(mod.qubits[q], mod.results[r])


# Class modeling joint ZZ measurements, vertical only!
class MeasureZZ(DoubleQubitGate):
    def __init__(
        self,
        mod: SimpleModule,
        qis: BasicQisBuilder,
        q1: int,
        q2: int,
        q_ancilla: int,
        grid_dims: tuple[int, int],
        r: int = None,
    ) -> None:
        super().__init__(q1, q2, grid_dims, Orientation.VERTICAL)

        if r is None:
            r = q_ancilla

        qis.reset(mod.qubits[q_ancilla])

        qis.cx(mod.qubits[q1], mod.qubits[q_ancilla])
        qis.cx(mod.qubits[q2], mod.qubits[q_ancilla])

        qis.mz(mod.qubits[q_ancilla], mod.results[r])


# Class modeling joint XX measurements, horizontal only!
class MeasureXX(DoubleQubitGate):
    def __init__(
        self,
        mod: SimpleModule,
        qis: BasicQisBuilder,
        q1: int,
        q2: int,
        q_ancilla: int,
        grid_dims: tuple[int, int],
        r: int = None,
    ) -> None:
        super().__init__(q1, q2, grid_dims, Orientation.HORIZONTAL)

        if r is None:
            r = q_ancilla

        qis.reset(mod.qubits[q_ancilla])

        qis.cx(mod.qubits[q1], mod.qubits[q_ancilla])
        qis.cx(mod.qubits[q2], mod.qubits[q_ancilla])

        qis.mz(mod.qubits[q_ancilla], mod.results[r])

        qis.h(mod.qubits[q1])
        qis.h(mod.qubits[q2])


# Class modeling Bell measurements
class MeasureBB(DoubleQubitGate):
    def __init__(
        self,
        mod: SimpleModule,
        qis: BasicQisBuilder,
        q1: int,
        q2: int,
        q_ancilla: int,
        grid_dims: tuple[int, int],
        r1: int = None,
        r21: int = None,
        r22: int = None,
    ) -> None:
        super().__init__(q1, q2, grid_dims)

        if self._orientation == Orientation.HORIZONTAL:
            MeasureXX(mod, qis, q1, q2, q_ancilla, grid_dims, r1)

            MeasureZ(mod, qis, q1, r21)
            MeasureZ(mod, qis, q2, r22)

        else:  # Vertical
            MeasureZZ(mod, qis, q1, q2, q_ancilla, grid_dims, r1)

            MeasureX(mod, qis, q1, r21)
            MeasureX(mod, qis, q2, r22)


# Class modeling move gates
class Move(DoubleQubitGate):
    def __init__(
        self,
        mod: SimpleModule,
        qis: BasicQisBuilder,
        frm: int,
        to: int,
        q_ancilla: int,
        grid_dims: tuple[int, int],
    ) -> None:
        super().__init__(frm, to, grid_dims)

        if self._orientation == Orientation.HORIZONTAL:
            PrepareZ(mod, qis, to)

            MeasureXX(mod, qis, frm, to, q_ancilla, grid_dims)

            MeasureZ(mod, qis, frm)

            qis.if_result(mod.results[q_ancilla], lambda: Z(mod, qis, to))
            qis.if_result(mod.results[frm], lambda: X(mod, qis, to))
        else:  # Vertical
            PrepareX(mod, qis, to)

            MeasureZZ(mod, qis, frm, to, q_ancilla, grid_dims)

            MeasureX(mod, qis, frm)

            qis.if_result(mod.results[q_ancilla], lambda: X(mod, qis, to))
            qis.if_result(mod.results[frm], lambda: Z(mod, qis, to))
