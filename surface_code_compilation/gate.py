from abc import ABC
from enum import Enum
from math import pi

from pyqir import SimpleModule, BasicQisBuilder, Value


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
        self, mod: SimpleModule, qis: BasicQisBuilder, q1: int, q2: int
    ) -> None:
        super().__init__(q1, q2)

        if self._orientation == Orientation.HORIZONTAL:
            PrepareZ(mod, qis, q1)
            PrepareZ(mod, qis, q2)

            res = mod.results[q1]
            MeasureXX(mod, qis, q1, q2, res)

            qis.if_result(res, lambda: Z(mod, qis, q2))

        else:  # Vertical
            PrepareX(mod, qis, q1)
            PrepareX(mod, qis, q2)

            res = mod.results[q1]
            MeasureZZ(mod, qis, q1, q2, res)

            qis.if_result(res, lambda: X(mod, qis, q2))


class MeasureZ(SingleQubitGate):
    def __init__(
        self, mod: SimpleModule, qis: BasicQisBuilder, q: int, res: Value
    ) -> None:
        super().__init__()

        qis.mz(mod.qubits[q], res)


class MeasureX(SingleQubitGate):
    def __init__(
        self, mod: SimpleModule, qis: BasicQisBuilder, q: int, res: Value
    ) -> None:
        super().__init__()

        qis.h(mod.qubits[q])
        qis.mz(mod.qubits[q], res)


# https://www.researchgate.net/publication/335179815_Entanglement_stabilization_using_ancilla-based_parity_detection_and_real-time_feedback_in_superconducting_circuits
class MeasureZZ(DoubleQubitGate):  # Vertical only
    def __init__(
        self,
        mod: SimpleModule,
        qis: BasicQisBuilder,
        q1: int,
        q2: int,
        a: int,
        res: Value,
    ) -> None:
        super().__init__(q1, q2, Orientation.VERTICAL)

        qis.reset(mod.qubits[a])  # TODO needed, which ancilla to use?

        qis.ry(pi / 2, mod.qubits[q1])
        qis.ry(pi / 2, mod.qubits[q2])

        qis.ry(-pi / 2, mod.qubits[a])

        qis.cx(mod.qubits[q1], mod.qubits[a])
        qis.cx(mod.qubits[q2], mod.qubits[a])

        qis.ry(pi / 2, mod.qubits[a])

        qis.mz(mod.qubits[a], res)

        qis.if_result(res, lambda: qis.rx(pi, mod.qubits[q2]))


# https://www.researchgate.net/publication/335179815_Entanglement_stabilization_using_ancilla-based_parity_detection_and_real-time_feedback_in_superconducting_circuits
class MeasureXX(DoubleQubitGate):  # Horizontal only
    def __init__(
        self,
        mod: SimpleModule,
        qis: BasicQisBuilder,
        q1: int,
        q2: int,
        a: int,
        res: Value,
    ) -> None:
        super().__init__(q1, q2, Orientation.HORIZONTAL)

        qis.reset(mod.qubits[a])  # TODO needed, which ancilla to use?

        qis.ry(pi, mod.qubits[q1])
        qis.ry(pi, mod.qubits[q2])

        qis.ry(-pi / 2, mod.qubits[a])

        qis.cx(mod.qubits[q1], mod.qubits[a])
        qis.cx(mod.qubits[q2], mod.qubits[a])

        qis.ry(pi / 2, mod.qubits[a])

        qis.mz(mod.qubits[a], res)

        qis.if_result(res, lambda: qis.rx(pi, mod.qubits[q2]))


class MeasureBB(DoubleQubitGate):
    def __init__(
        self,
        mod: SimpleModule,
        qis: BasicQisBuilder,
        q1: int,
        q2: int,
        res1: Value,
        res2: Value,
    ) -> None:
        super().__init__(q1, q2)

        if self._orientation == Orientation.HORIZONTAL:
            MeasureXX(mod, qis, q1, q2, res1)

            temp: Value = (
                None  # TODO: wrong, need 3 results, the temp one is not accepted
            )
            MeasureZ(mod, qis, q1, temp)
            MeasureZ(mod, qis, q2, res2)

        else:  # Vertical
            MeasureZZ(mod, qis, q1, q2, res1)

            temp: Value = (
                None  # TODO: wrong, need 3 results, the temp one is not accepted
            )
            MeasureX(mod, qis, q1, temp)
            MeasureX(mod, qis, q2, res2)

        res2 = mod.builder.xor(temp, res2)


class Move(DoubleQubitGate):
    def __init__(
        self, mod: SimpleModule, qis: BasicQisBuilder, frm: int, to: int
    ) -> None:
        super().__init__(frm, to)

        if self._orientation == Orientation.HORIZONTAL:
            PrepareZ(mod, qis, to)

            x = mod.results[frm]
            MeasureXX(mod, qis, frm, to, x)

            z = mod.results[to]
            MeasureZ(mod, qis, frm, z)

            qis.if_result(x, lambda: Z(mod, qis, to))
            qis.if_result(z, lambda: X(mod, qis, to))
        else:  # Vertical
            PrepareX(mod, qis, to)

            z = mod.results[frm]
            MeasureZZ(mod, qis, frm, to, z)

            x = mod.results[to]
            MeasureX(mod, qis, frm, x)

            qis.if_result(z, lambda: X(mod, qis, to))
            qis.if_result(x, lambda: Z(mod, qis, to))
