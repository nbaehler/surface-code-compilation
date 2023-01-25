from abc import ABC
from enum import Enum


class Orientation(Enum):
    HORIZONTAL = 0
    VERTICAL = 1


# class modeling gates in the intermediate representation
class Gate(ABC):
    def __init__(self) -> None:
        super().__init__()


class SingleQubitGate(Gate):
    def __init__(self, q: int) -> None:
        super().__init__()
        self._q = q


class DoubleQubitGate(Gate):
    def __init__(self, q1: int, q2: int, orientation: Orientation = None) -> None:
        super().__init__()
        self._q1 = q1
        self._q2 = q2

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
    def __init__(self, q: int) -> None:
        super().__init__(q)


class X(SingleQubitGate):
    def __init__(self, q: int) -> None:
        super().__init__(q)


class PrepareX(SingleQubitGate):
    def __init__(self, q: int) -> None:
        super().__init__(q)

    #     AssertAllZero([q])
    #     H(q)


class PrepareZ(SingleQubitGate):
    def __init__(self, q: int) -> None:
        super().__init__(q)

        # AssertAllZero([q])


class PrepareBB(DoubleQubitGate):
    def __init__(self, q1: int, q2: int) -> None:
        super().__init__(q1, q2)

        if self._orientation == Orientation.HORIZONTAL:
            pass

            # AssertAllZero([q1, q2])

            # PrepareZ(q1)
            # PrepareZ(q2)

            # let x = HorizontalMeasureXX(q1, q2)

            # if x == One {
            #     Z(q2)
            # }

        else:  # Vertical
            pass
            # AssertAllZero([q1, q2])

            # PrepareX(q1)
            # PrepareX(q2)

            # let z = VerticalMeasureZZ(q1, q2)

            # if z == One {
            #     X(q2)
            # }


class MeasureZ(SingleQubitGate):
    def __init__(self, q: int) -> None:
        super().__init__(q)

        # return MResetZ(q) # M in Z and then set to |0>


class MeasureX(SingleQubitGate):
    def __init__(self, q: int) -> None:
        super().__init__(q)

        # return MResetX(q) # M in X and then set to |0>


class MeasureZZ(DoubleQubitGate):  # Vertical only
    def __init__(self, q1: int, q2: int) -> None:
        super().__init__(q1, q2, Orientation.VERTICAL)

        # Return Zero or One, not |00> etc. Those are the eigenvalues associated to the sub vector spaces. https:#learn.microsoft.com/en-us/azure/quantum/concepts-pauli-measurements
        # return Measure([PauliZ, PauliZ], [q1, q2])


class MeasureXX(DoubleQubitGate):  # Horizontal only
    def __init__(self, q1: int, q2: int) -> None:
        super().__init__(q1, q2, Orientation.HORIZONTAL)

        # return Measure([PauliX, PauliX], [q1, q2])


class MeasureBB(DoubleQubitGate):  # TODO not sure
    def __init__(self, q1: int, q2: int) -> None:
        super().__init__(q1, q2)

        if self._orientation == Orientation.HORIZONTAL:
            pass

            # let z = VerticalMeasureZZ(q1, q2)
            # let x1 = MeasureX(q1)
            # let x2 = MeasureX(q2)
            # let x = BoolAsResult(x1 != x2)

            # return [x, z] # Not sure!

        else:  # Vertical
            pass

            # let x = HorizontalMeasureXX(q1, q2)
            # let z1 = MeasureZ(q1)
            # let z2 = MeasureZ(q2)
            # let z = BoolAsResult(z1 != z2)

            # return [x, z] # Not sure!


class Move(DoubleQubitGate):
    def __init__(self, frm: int, to: int) -> None:
        super().__init__(frm, to)

        if self._orientation == Orientation.HORIZONTAL:
            pass

            # PrepareX(to)

            # let z = VerticalMeasureZZ(frm, to)
            # let x = MeasureX(frm)

            # if z == One {
            #     X(to)
            # }

            # if x == One {
            #     Z(to)
            # }

        else:  # Vertical
            pass

            # PrepareZ(to)

            # let x = HorizontalMeasureXX(frm, to)
            # let z = MeasureZ(frm)

            # if x == One {
            #     Z(to)
            # }

            # if z == One {
            #     X(to)
            # }


# class LocalCnot(ctl : int, tgt : int, hlp : int): Unit {
#     PrepareX(hlp)

#     let a = VerticalMeasureZZ(ctl, hlp)
#     let b = HorizontalMeasureXX(hlp, tgt)
#     let c = MeasureZ(hlp)

#     if b == One {
#         Z(ctl)
#     }

#     if c != a {
#         X(tgt)
#     }
# }

# CNOT gate in the intermediate representation
# class CNOT(Gate):  # TODO add all gates that I need
#     def __init__(self, control: int, target: int) -> None:
#         super().__init__()
#         self._control = control
#         self._target = target
