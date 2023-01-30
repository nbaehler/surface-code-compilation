from abc import ABC
from enum import Enum

from pyqir import BasicQisBuilder, SimpleModule


class Orientation(Enum):
    HORIZONTAL = 0
    VERTICAL = 1


# class modeling gates in the intermediate representation
class Gate(ABC):
    def __init__(self) -> None:
        super().__init__()


class SingleQubitGate(Gate):
    def __init__(self) -> None:
        super().__init__()


class DoubleQubitGate(Gate):
    def __init__(
        self,
        q1: int,
        q2: int,
        orientation: Orientation = None,
    ) -> None:
        super().__init__()

        if orientation is not None:
            assert (
                orientation == Orientation.HORIZONTAL
                if q1 == q2 + 1
                else Orientation.VERTICAL
            )

        self._orientation = (
            Orientation.HORIZONTAL if q1 == q2 + 1 else Orientation.VERTICAL
        )  # TODO: check if this is correct in all cases


class Z(SingleQubitGate):
    def __init__(self, mod: SimpleModule, qis: BasicQisBuilder, q: int) -> None:
        super().__init__()

        qis.z(mod.qubits[q])


class X(SingleQubitGate):
    def __init__(self, mod: SimpleModule, qis: BasicQisBuilder, q: int) -> None:
        super().__init__()

        qis.x(mod.qubits[q])


class PrepareX(SingleQubitGate):
    def __init__(self, mod: SimpleModule, qis: BasicQisBuilder, q: int) -> None:
        super().__init__()

        qis.reset(mod.qubits[q])
        qis.h(mod.qubits[q])


class PrepareZ(SingleQubitGate):
    def __init__(self, mod: SimpleModule, qis: BasicQisBuilder, q: int) -> None:
        super().__init__()

        qis.reset(mod.qubits[q])


class PrepareBB(DoubleQubitGate):
    def __init__(
        self, mod: SimpleModule, qis: BasicQisBuilder, q1: int, q2: int, q_ancilla: int
    ) -> None:
        super().__init__(q1, q2)

        if self._orientation == Orientation.HORIZONTAL:
            PrepareZ(mod, qis, q1)
            PrepareZ(mod, qis, q2)

            MeasureXX(mod, qis, q1, q2, q_ancilla)

            qis.if_result(mod.results[q_ancilla], lambda: Z(mod, qis, q2))

        else:  # Vertical
            PrepareX(mod, qis, q1)
            PrepareX(mod, qis, q2)

            MeasureZZ(mod, qis, q1, q2, q_ancilla)

            qis.if_result(mod.results[q_ancilla], lambda: X(mod, qis, q2))


class MeasureZ(SingleQubitGate):
    def __init__(
        self, mod: SimpleModule, qis: BasicQisBuilder, q: int, r: int = None
    ) -> None:
        super().__init__()

        if r is None:
            r = q

        qis.mz(mod.qubits[q], mod.results[r])


class MeasureX(SingleQubitGate):
    def __init__(
        self, mod: SimpleModule, qis: BasicQisBuilder, q: int, r: int = None
    ) -> None:
        super().__init__()

        if r is None:
            r = q

        qis.h(mod.qubits[q])
        qis.mz(mod.qubits[q], mod.results[r])


class MeasureZZ(DoubleQubitGate):  # Vertical only
    def __init__(
        self,
        mod: SimpleModule,
        qis: BasicQisBuilder,
        q1: int,
        q2: int,
        q_ancilla: int,
        r: int = None,
    ) -> None:
        super().__init__(q1, q2, Orientation.VERTICAL)

        if r is None:
            r = q_ancilla

        qis.reset(mod.qubits[q_ancilla])

        qis.cx(mod.qubits[q1], mod.qubits[q_ancilla])
        qis.cx(mod.qubits[q2], mod.qubits[q_ancilla])

        qis.mz(mod.qubits[q_ancilla], mod.results[r])


class MeasureXX(DoubleQubitGate):  # Horizontal only
    def __init__(
        self,
        mod: SimpleModule,
        qis: BasicQisBuilder,
        q1: int,
        q2: int,
        q_ancilla: int,
        r: int = None,
    ) -> None:
        super().__init__(q1, q2, Orientation.HORIZONTAL)

        if r is None:
            r = q_ancilla

        qis.reset(mod.qubits[q_ancilla])

        qis.cx(mod.qubits[q1], mod.qubits[q_ancilla])
        qis.cx(mod.qubits[q2], mod.qubits[q_ancilla])

        qis.mz(mod.qubits[q_ancilla], mod.results[r])

        qis.h(mod.qubits[q1])
        qis.h(mod.qubits[q2])


class MeasureBB(DoubleQubitGate):
    def __init__(
        self,
        mod: SimpleModule,
        qis: BasicQisBuilder,
        q1: int,
        q2: int,
        q_ancilla: int,
        r1: int = None,
        r2: int = None,
    ) -> None:
        super().__init__(q1, q2)

        if self._orientation == Orientation.HORIZONTAL:
            MeasureXX(mod, qis, q1, q2, q_ancilla, r1)

            MeasureZ(mod, qis, q1, r2)
            MeasureZ(mod, qis, q2, q_ancilla)

        else:  # Vertical
            MeasureZZ(mod, qis, q1, q2, q_ancilla, r1)

            MeasureX(mod, qis, q1, r2)
            MeasureX(mod, qis, q2, q_ancilla)

        # mod.results[r2] = mod.builder.xor(mod.results[r2], mod.results[q_ancilla]) # TODO: xor


class Move(DoubleQubitGate):
    def __init__(
        self, mod: SimpleModule, qis: BasicQisBuilder, frm: int, to: int, q_ancilla: int
    ) -> None:
        super().__init__(frm, to)

        if self._orientation == Orientation.HORIZONTAL:
            PrepareZ(mod, qis, to)

            MeasureXX(mod, qis, frm, to, q_ancilla)

            MeasureZ(mod, qis, frm)

            qis.if_result(mod.results[q_ancilla], lambda: Z(mod, qis, to))
            qis.if_result(mod.results[frm], lambda: X(mod, qis, to))
        else:  # Vertical
            PrepareX(mod, qis, to)

            MeasureZZ(mod, qis, frm, to, q_ancilla)

            MeasureX(mod, qis, frm)

            qis.if_result(mod.results[q_ancilla], lambda: X(mod, qis, to))
            qis.if_result(mod.results[frm], lambda: Z(mod, qis, to))
