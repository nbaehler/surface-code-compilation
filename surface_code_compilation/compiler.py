from gate import (
    Z,
    X,
    PrepareZ,
    PrepareX,
    PrepareBB,
    MeasureZ,
    MeasureX,
    MeasureZZ,
    MeasureXX,
    MeasureBB,
    Move,
)

from path import Path, PathType
from helpers import flatten, is_data_qubit

from functools import reduce
from pyqir import SimpleModule, BasicQisBuilder, Value
import numpy as np

# Class the compiles a scheduling into qir
class Compiler:
    def __init__(
        self,
        grid_dims: tuple[int, int],
        scheduling: list[list[Path]],
    ) -> None:
        self._grid_dims: tuple[int, int] = grid_dims
        self._scheduling: list[list[Path]] = scheduling

    # Compile into qir
    def compile(self) -> str:
        n_qubits = np.prod(self._grid_dims, dtype=int)

        mod = SimpleModule("Output", num_qubits=n_qubits, num_results=n_qubits)
        qis = BasicQisBuilder(mod.builder)

        for epoch in self._scheduling:
            for path in epoch:
                if path.get_type() == PathType.LONG_RANGE_CNOT:
                    self._compile_long_range_cnot(mod, qis, path)
                elif path.get_type() == PathType.PHASE_1:
                    self._compile_phase_1(mod, qis, path)
                else:  # path.get_type() == PathType.PHASE_2:
                    self._compile_phase_2(mod, qis, path)

        return mod.ir()

    def _compile_long_range_cnot(
        self, mod: SimpleModule, qis: BasicQisBuilder, path: Path
    ) -> None:
        self._long_range_bell_prep(mod, qis, path.interior())

        # Measure ZZ => b
        q1 = flatten(*path[0], self._grid_dims)
        q2 = flatten(*path[1], self._grid_dims)
        b = mod.results[q1]
        MeasureZZ(mod, qis, q1, q2, b)

        # Measure XX => a
        q1 = flatten(*path[-2], self._grid_dims)
        q2 = flatten(*path[-1], self._grid_dims)
        a = mod.results[q1]
        MeasureXX(mod, qis, q1, q2, a)

        # Measure X => c
        q = flatten(*path[1], self._grid_dims)
        c = mod.results[q]
        MeasureX(mod, qis, q, c)

        # Measure Z => d
        q = flatten(*path[-2], self._grid_dims)
        d = mod.results[q]
        MeasureZ(mod, qis, q, d)

        a_xor_c = mod.builder.xor(a, c)
        b_xor_d = mod.builder.xor(b, d)

        # Z
        q = flatten(*path[0], self._grid_dims)
        qis.if_result(
            a_xor_c,
            lambda: Z(mod, qis, q),
        )

        # X
        q = flatten(*path[-1], self._grid_dims)
        qis.if_result(
            b_xor_d,
            lambda: X(mod, qis, q),
        )

    def _compile_phase_1(
        self, mod: SimpleModule, qis: BasicQisBuilder, path: Path
    ) -> None:
        if is_data_qubit(path[0]):  # Control
            self._long_range_X_prep_with_ZZ_meas(mod, qis, path)
        elif is_data_qubit(path[-1]):  # Target
            self._long_range_Z_prep_with_XX_meas(mod, qis, path)
        else:
            self._long_range_bell_prep(mod, qis, path)

    def _compile_phase_2(
        self, mod: SimpleModule, qis: BasicQisBuilder, path: Path
    ) -> None:
        if is_data_qubit(path[0]):  # Control
            self._long_range_teleport_with_ZZ_meas(mod, qis, path)
        elif is_data_qubit(path[-1]):  # Target
            self._long_range_teleport_with_XX_meas(mod, qis, path)
        else:
            self._long_range_bell_meas(mod, qis, path)

    def _long_range_bell_prep(
        self, mod: SimpleModule, qis: BasicQisBuilder, path: Path
    ) -> None:
        if len(path) % 2 == 1:
            end = len(path) - 2

            # Move
            frm = flatten(*path[-2], self._grid_dims)
            to = flatten(*path[-1], self._grid_dims)
            Move(
                mod,
                qis,
                frm,
                to,
            )
        else:
            end = len(path) - 1

        for i in range(0, end, 2):
            # Prepare BB
            q1 = flatten(*path[i], self._grid_dims)
            q2 = flatten(*path[i + 1], self._grid_dims)
            PrepareBB(
                mod,
                qis,
                q1,
                q2,
            )

        x = []
        z = []

        for i in range(1, end - 1, 2):
            # Measure BB
            q1 = flatten(*path[i], self._grid_dims)
            q2 = flatten(*path[i + 1], self._grid_dims)
            x.append(mod.results[q1])
            z.append(mod.results[q2])
            MeasureBB(
                mod,
                qis,
                q1,
                q2,
                x[-1],
                z[-1],
            )

        def f(a, b):
            return mod.builder.xor(a, b)

        [x, z] = reduce(f, x), reduce(f, z)

        q = flatten(*path[-1], self._grid_dims)

        # Z
        qis.if_result(x, lambda: Z(mod, qis, q))

        # X
        qis.if_result(z, lambda: X(mod, qis, q))

    def _long_range_bell_meas(
        self, mod: SimpleModule, qis: BasicQisBuilder, path: Path
    ) -> tuple[Value, Value]:
        if len(path) % 2 == 1:
            end = len(path) - 2

            # Move
            frm = flatten(*path[-1], self._grid_dims)
            to = flatten(*path[-2], self._grid_dims)
            Move(mod, qis, frm, to)
        else:
            end = len(path) - 1

        for i in range(1, end - 1, 2):
            # Prepare BB
            q1 = flatten(*path[i], self._grid_dims)
            q2 = flatten(*path[i + 1], self._grid_dims)
            PrepareBB(mod, qis, q1, q2)

        x = []
        z = []

        for i in range(0, end, 2):
            # Measure BB
            q1 = flatten(*path[i], self._grid_dims)
            q2 = flatten(*path[i + 1], self._grid_dims)
            x.append(mod.results[q1])
            z.append(mod.results[q2])
            MeasureBB(
                mod,
                qis,
                q1,
                q2,
                x[-1],
                z[-1],
            )

        def f(a, b):
            return mod.builder.xor(a, b)

        return reduce(f, x), reduce(f, z)

    def _long_range_X_prep_with_ZZ_meas(
        self, mod: SimpleModule, qis: BasicQisBuilder, path: Path
    ) -> None:
        # Prepare X
        q = flatten(*path[1], self._grid_dims)
        PrepareX(mod, qis, q)

        if len(path) % 2 == 1:
            end = len(path) - 1

            # Move
            frm = flatten(*path[-2], self._grid_dims)
            to = flatten(*path[-1], self._grid_dims)
            Move(mod, qis, frm, to)

        else:
            end = len(path)

        for i in range(2, end, 2):
            # Prepare BB
            q1 = flatten(*path[i], self._grid_dims)
            q2 = flatten(*path[i + 1], self._grid_dims)
            PrepareBB(mod, qis, q1, q2)

        # Measure ZZ
        q1 = flatten(*path[0], self._grid_dims)
        q2 = flatten(*path[1], self._grid_dims)
        z1 = mod.results[q1]
        MeasureZZ(mod, qis, q1, q2, z1)

        x2 = []
        z2 = []

        for i in range(1, end - 1, 2):
            # Measure BB
            q1 = flatten(*path[i], self._grid_dims)
            q2 = flatten(*path[i + 1], self._grid_dims)
            x2.append(mod.results[q1])
            z2.append(mod.results[q2])
            MeasureBB(
                mod,
                qis,
                q1,
                q2,
                x2[-1],
                z2[-1],
            )

        def f(a, b):
            return mod.builder.xor(a, b)

        [x, z] = reduce(f, x2), reduce(f, z2)
        z = mod.builder.xor(z, z1)

        q = flatten(*path[-1], self._grid_dims)

        # Z
        qis.if_result(x, lambda: Z(mod, qis, q))

        # X
        qis.if_result(z, lambda: X(mod, qis, q))

    def _long_range_Z_prep_with_XX_meas(
        self, mod: SimpleModule, qis: BasicQisBuilder, path: Path
    ) -> None:
        # Prepare Z
        q = flatten(*path[-2], self._grid_dims)
        PrepareZ(mod, qis, q)

        if len(path) % 2 == 1:
            end = len(path) - 1

            # Move
            frm = flatten(*path[-1], self._grid_dims)
            to = flatten(*path[-2], self._grid_dims)

            Move(mod, qis, frm, to)

        else:
            end = len(path)

        for i in range(0, end, 2):
            # Prepare BB
            q1 = flatten(*path[i], self._grid_dims)
            q2 = flatten(*path[i + 1], self._grid_dims)
            PrepareBB(mod, qis, q1, q2)

        # Measure XX
        q1 = flatten(*path[-1], self._grid_dims)
        q2 = flatten(*path[-2], self._grid_dims)
        x1 = mod.results[q1]

        MeasureXX(mod, qis, q1, q2, x1)

        x2 = []
        z2 = []

        for i in range(1, end - 1, 2):
            # Measure BB
            q1 = flatten(*path[i], self._grid_dims)
            q2 = flatten(*path[i + 1], self._grid_dims)
            x2.append(mod.results[q1])
            z2.append(mod.results[q2])
            MeasureBB(mod, qis, q1, q2, x2[-1], z2[-1])

        def f(a, b):
            return mod.builder.xor(a, b)

        [x, z] = reduce(f, x2), reduce(f, z2)
        x = mod.builder.xor(x, x1)

        q = flatten(*path[0], self._grid_dims)

        # X
        qis.if_result(z, lambda: X(mod, qis, q))

        # Z
        qis.if_result(x, lambda: Z(mod, qis, q))

    def _long_range_teleport_with_ZZ_meas(
        self, mod: SimpleModule, qis: BasicQisBuilder, path: Path
    ) -> None:
        if len(path) % 2 == 1:
            end = len(path) - 2

            # Move
            frm = flatten(*path[-1], self._grid_dims)
            to = flatten(*path[-2], self._grid_dims)
            Move(mod, qis, frm, to)
        else:
            end = len(path) - 1

        for i in range(1, end - 1, 2):
            # Prepare BB
            q1 = flatten(*path[i], self._grid_dims)
            q2 = flatten(*path[i + 1], self._grid_dims)
            PrepareBB(mod, qis, q1, q2)

        a1 = []

        for i in range(2, end, 2):
            # Measure BB
            q1 = flatten(*path[i], self._grid_dims)
            q2 = flatten(*path[i + 1], self._grid_dims)
            a1.extend((mod.results[q1], mod.results[q2]))
            MeasureBB(mod, qis, q1, q2, a1[-2], a1[-1])

        # Measure ZZ
        q1 = flatten(*path[0], self._grid_dims)
        q2 = flatten(*path[1], self._grid_dims)
        a2 = mod.results[q1]
        MeasureZZ(mod, qis, q1, q2, a2)

        # Measure X
        q = flatten(*path[1], self._grid_dims)
        a3 = mod.results[q]
        MeasureX(mod, qis, q, a3)

        def f(a, b):
            return mod.builder.xor(a, b)

        a = reduce(f, a1)
        a = mod.builder.xor(a, a2)
        a = mod.builder.xor(a, a3)

        # Z
        q = flatten(*path[0], self._grid_dims)
        qis.if_result(a, lambda: Z(mod, qis, q))

    def _long_range_teleport_with_XX_meas(
        self, mod: SimpleModule, qis: BasicQisBuilder, path: Path
    ) -> None:
        if len(path) % 2 == 1:
            end = len(path) - 1

            # Move
            frm = flatten(*path[-2], self._grid_dims)
            to = flatten(*path[-1], self._grid_dims)
            Move(
                mod,
                qis,
                frm,
                to,
            )

        else:
            end = len(path)

        for i in range(1, end - 1, 2):
            # Prepare BB
            q1 = flatten(*path[i], self._grid_dims)
            q2 = flatten(*path[i + 1], self._grid_dims)
            PrepareBB(mod, qis, q1, q2)

        # Measure XX
        q1 = flatten(*path[-2], self._grid_dims)
        q2 = flatten(*path[-1], self._grid_dims)
        a1 = mod.results[q1]
        MeasureXX(mod, qis, q1, q2, a1)

        a2 = []

        for i in range(0, end - 2, 2):
            # Measure BB
            q1 = flatten(*path[i], self._grid_dims)
            q2 = flatten(*path[i + 1], self._grid_dims)
            a2.extend((mod.results[q1], mod.results[q2]))
            MeasureBB(mod, qis, q1, q2, a2[-2], a2[-1])

        # Measure Z
        q = flatten(*path[-2], self._grid_dims)
        a3 = mod.results[q]
        MeasureZ(mod, qis, q, a3)

        def f(a, b):
            return mod.builder.xor(a, b)

        a = reduce(f, a2)
        a = mod.builder.xor(a, a1)
        a = mod.builder.xor(a, a3)

        # X
        q = flatten(*path[-1], self._grid_dims)
        qis.if_result(a, lambda: X(mod, qis, q))
