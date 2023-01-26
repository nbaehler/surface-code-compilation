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

        self._mod = SimpleModule("output", num_qubits=n_qubits, num_results=n_qubits)
        self._qis = BasicQisBuilder(self._mod.builder)

        # for epoch in self._scheduling: # TODO: uncomment
        #     for path in epoch:
        # if path.get_type() == PathType.LONG_RANGE_CNOT:
        #     self._compile_long_range_cnot(path)
        # elif path.get_type() == PathType.PHASE_1:
        #     self._compile_phase_1(path)
        # else:  # path.get_type() == PathType.PHASE_2:
        #     self._compile_phase_2(path)

        return self._mod.ir()

    def _compile_long_range_cnot(self, path: Path) -> None:
        self._long_range_bell_prep(path.interior())

        # Measure ZZ => b
        q1 = flatten(*path[0], self._grid_dims)
        q2 = flatten(*path[1], self._grid_dims)
        b = self._mod.results[q1]
        MeasureZZ(self._mod, self._qis, q1, q2, b)

        # Measure XX => a
        q1 = flatten(*path[-2], self._grid_dims)
        q2 = flatten(*path[-1], self._grid_dims)
        a = self._mod.results[q2]
        MeasureXX(self._mod, self._qis, q1, q2, a)

        # Measure X => c
        q = flatten(*path[1], self._grid_dims)
        c = self._mod.results[q]
        MeasureX(self._mod, self._qis, q, c)

        # Measure Z => d
        q = flatten(*path[-2], self._grid_dims)
        d = self._mod.results[q]
        MeasureZ(self._mod, self._qis, q, d)

        a_xor_c = self._mod.builder.xor(a, c)
        b_xor_d = self._mod.builder.xor(b, d)

        # Z
        q = flatten(*path[0], self._grid_dims)
        self._qis.if_result(
            a_xor_c,
            lambda: Z(self._mod, self._qis, q),
        )

        # X
        q = flatten(*path[-1], self._grid_dims)
        self._qis.if_result(
            b_xor_d,
            lambda: X(self._mod, self._qis, q),
        )

    def _compile_phase_1(self, path: Path) -> None:
        if is_data_qubit(path[0]):  # Control
            self._long_range_X_prep_with_ZZ_meas(path)
        elif is_data_qubit(path[-1]):  # Target
            self._long_range_Z_prep_with_XX_meas(path)
        else:
            self._long_range_bell_prep(path)

    def _compile_phase_2(self, path: Path) -> None:
        if is_data_qubit(path[0]):  # Control
            self._long_range_teleport_with_ZZ_meas(path)
        elif is_data_qubit(path[-1]):  # Target
            self._long_range_teleport_with_XX_meas(path)
        else:
            self._long_range_bell_meas(path)

    def _xor(self, a, b):
        return self._mod.builder.xor(a, b)

    def _bell_chain(
        self, path: Path, first: int, last: int
    ) -> tuple[Value, Value]:  # Path length is always even
        r_prep = range(first + 1, last - 1, 2)
        r_meas = range(first, last + 1, 2)

        for i in r_prep:
            # Prepare BB
            q1 = flatten(*path[i], self._grid_dims)
            q2 = flatten(*path[i + 1], self._grid_dims)
            PrepareBB(
                self._mod,
                self._qis,
                q1,
                q2,
            )

        x = []
        z = []

        for i in r_meas:
            # Measure BB
            q1 = flatten(*path[i], self._grid_dims)
            q2 = flatten(*path[i + 1], self._grid_dims)
            x.append(self._mod.results[q1])
            z.append(self._mod.results[q2])
            MeasureBB(
                self._mod,
                self._qis,
                q1,
                q2,
                x[-1],
                z[-1],
            )

        return reduce(self._xor, x), reduce(self._xor, z)

    def _long_range_bell_prep(self, path: Path) -> None:  # Path length is always odd
        # Prepare BB at start
        q1 = flatten(*path[0], self._grid_dims)
        q2 = flatten(*path[1], self._grid_dims)
        PrepareBB(
            self._mod,
            self._qis,
            q1,
            q2,
        )

        # Prepare BB at end
        q1 = flatten(*path[-3], self._grid_dims)
        q2 = flatten(*path[-2], self._grid_dims)
        PrepareBB(
            self._mod,
            self._qis,
            q1,
            q2,
        )

        # Bell chain
        [x, z] = self._bell_chain(path, first=1, last=len(path) - 4)

        # Move
        frm = flatten(*path[-2], self._grid_dims)
        to = flatten(*path[-1], self._grid_dims)
        Move(
            self._mod,
            self._qis,
            frm,
            to,
        )

        q = flatten(*path[-1], self._grid_dims)

        # X
        self._qis.if_result(z, lambda: X(self._mod, self._qis, q))

        # Z
        self._qis.if_result(x, lambda: Z(self._mod, self._qis, q))

    def _long_range_bell_meas(
        self, path: Path
    ) -> tuple[Value, Value]:  # Path length is always odd
        # Move
        frm = flatten(
            *path[-1], self._grid_dims
        )  # TODO is the direction of the move correct, strange in paper?
        to = flatten(*path[-2], self._grid_dims)
        Move(
            self._mod,
            self._qis,
            frm,
            to,
        )

        # Bell chain
        return self._bell_chain(path, first=0, last=len(path) - 3)

    def _long_range_X_prep_with_ZZ_meas(
        self, path: Path
    ) -> None:  # Path length is always even
        # Prepare X
        q = flatten(*path[1], self._grid_dims)
        PrepareX(self._mod, self._qis, q)

        # Measure ZZ
        q1 = flatten(*path[0], self._grid_dims)
        q2 = flatten(*path[1], self._grid_dims)
        z_joint = self._mod.results[q1]
        MeasureZZ(self._mod, self._qis, q1, q2, z_joint)

        # Prepare BB at end
        q1 = flatten(*path[-2], self._grid_dims)
        q2 = flatten(*path[-1], self._grid_dims)
        PrepareBB(
            self._mod,
            self._qis,
            q1,
            q2,
        )

        # Bell chain
        [x, z_chain] = self._bell_chain(path, first=1, last=len(path) - 3)
        z = self._mod.builder.xor(z_chain, z_joint)

        q = flatten(*path[-1], self._grid_dims)

        # Z
        self._qis.if_result(x, lambda: Z(self._mod, self._qis, q))

        # X
        self._qis.if_result(z, lambda: X(self._mod, self._qis, q))

    def _long_range_Z_prep_with_XX_meas(
        self, path: Path
    ) -> None:  # Path length is always even
        # Prepare Z
        q = flatten(*path[-2], self._grid_dims)
        PrepareZ(self._mod, self._qis, q)

        # Measure XX
        q1 = flatten(*path[-2], self._grid_dims)
        q2 = flatten(*path[-1], self._grid_dims)
        x_joint = self._mod.results[q2]
        MeasureXX(self._mod, self._qis, q1, q2, x_joint)

        # Prepare BB at start
        q1 = flatten(*path[0], self._grid_dims)
        q2 = flatten(*path[1], self._grid_dims)
        PrepareBB(
            self._mod,
            self._qis,
            q1,
            q2,
        )

        # Bell chain
        [x_chain, z] = self._bell_chain(path, first=1, last=len(path) - 3)
        x = self._mod.builder.xor(x_chain, x_joint)

        q = flatten(*path[0], self._grid_dims)

        # X
        self._qis.if_result(z, lambda: X(self._mod, self._qis, q))

        # Z
        self._qis.if_result(x, lambda: Z(self._mod, self._qis, q))

    def _long_range_teleport_with_ZZ_meas(
        self, path: Path
    ) -> None:  # Path length is always even
        # Prepare BB at start
        q1 = flatten(*path[1], self._grid_dims)
        q2 = flatten(*path[2], self._grid_dims)
        PrepareBB(
            self._mod,
            self._qis,
            q1,
            q2,
        )

        # Bell chain
        [x_chain, z_chain] = self._bell_chain(path, first=2, last=len(path) - 2)

        # Measure ZZ
        q1 = flatten(*path[0], self._grid_dims)
        q2 = flatten(*path[1], self._grid_dims)
        z_joint = self._mod.results[q1]
        MeasureZZ(self._mod, self._qis, q1, q2, z_joint)

        # Measure X
        q = flatten(*path[1], self._grid_dims)
        x = self._mod.results[q]
        MeasureX(self._mod, self._qis, q, x)

        a = self._mod.builder.xor(x_chain, z_chain)
        a = self._mod.builder.xor(a, z_joint)
        a = self._mod.builder.xor(a, x)

        # Z
        q = flatten(*path[0], self._grid_dims)
        self._qis.if_result(a, lambda: Z(self._mod, self._qis, q))

    def _long_range_teleport_with_XX_meas(
        self, path: Path
    ) -> None:  # Path length is always even
        # Prepare BB at end
        q1 = flatten(*path[-3], self._grid_dims)
        q2 = flatten(*path[-2], self._grid_dims)
        PrepareBB(
            self._mod,
            self._qis,
            q1,
            q2,
        )

        # Bell chain
        [x_chain, z_chain] = self._bell_chain(path, first=0, last=len(path) - 3)

        # Measure XX
        q1 = flatten(*path[-2], self._grid_dims)
        q2 = flatten(*path[-1], self._grid_dims)
        x_joint = self._mod.results[q1]
        MeasureXX(self._mod, self._qis, q1, q2, x_joint)

        # Measure Z
        q = flatten(*path[-2], self._grid_dims)
        z = self._mod.results[q]
        MeasureZ(self._mod, self._qis, q, z)

        a = self._mod.builder.xor(x_chain, z_chain)
        a = self._mod.builder.xor(a, x_joint)
        a = self._mod.builder.xor(a, z)

        # X
        q = flatten(*path[-1], self._grid_dims)
        self._qis.if_result(a, lambda: X(self._mod, self._qis, q))
