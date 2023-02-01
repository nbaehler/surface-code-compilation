import numpy as np
from gate import (
    MeasureBB,
    MeasureX,
    MeasureXX,
    MeasureZ,
    MeasureZZ,
    Move,
    PrepareBB,
    PrepareX,
    PrepareZ,
    X,
    Z,
)
from helpers import flatten, is_data_qubit, make_runnable
from path import Path, PathType
from pyqir import BasicQisBuilder, SimpleModule


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
        n_qubits: int = np.prod(self._grid_dims, dtype=int)

        self._mod = SimpleModule(
            "output", num_qubits=n_qubits + 1, num_results=n_qubits + 5
        )

        self._q_ancilla: int = n_qubits
        self._r: list[int] = list(range(n_qubits + 1, n_qubits + 5))

        self._qis = BasicQisBuilder(self._mod.builder)

        for epoch in self._scheduling:
            for path in epoch:
                if path.get_type() == PathType.LONG_RANGE_CNOT:
                    self._compile_long_range_cnot(path)
                elif path.get_type() == PathType.PHASE_1:
                    self._compile_phase_1(path)
                else:  # path.get_type() == PathType.PHASE_2:
                    self._compile_phase_2(path)

        make_runnable(self._mod)

        return self._mod.ir()

    def _get_q(self, vertex_idx: tuple[int, int]) -> int:
        return flatten(*vertex_idx, self._grid_dims)

    # Minimum number of qubits in a path is 5
    def _compile_long_range_cnot(self, path: Path) -> None:
        self._long_range_bell_prep(path.interior())

        # Measure ZZ => b
        q1 = self._get_q(path[0])
        q2 = self._get_q(path[1])
        b = self._r[0]
        MeasureZZ(self._mod, self._qis, q1, q2, self._q_ancilla, b)

        # Measure XX => a
        q1 = self._get_q(path[-2])
        q2 = self._get_q(path[-1])
        a = self._r[1]
        MeasureXX(self._mod, self._qis, q1, q2, self._q_ancilla, a)

        # Measure X => c
        q = self._get_q(path[1])
        c = self._r[2]
        MeasureX(self._mod, self._qis, q, c)

        # Measure Z => d
        q = self._get_q(path[-2])
        d = self._r[3]
        MeasureZ(self._mod, self._qis, q, d)

        # a_xor_c = self._mod.builder.xor(
        #     self._mod.results[a], self._mod.results[c]
        # )  # TODO: xor
        # b_xor_d = self._mod.builder.xor(self._mod.results[b], self._mod.results[d])
        a_xor_c = self._mod.results[a]
        b_xor_d = self._mod.results[b]

        # Z
        q = self._get_q(path[0])
        self._qis.if_result(
            a_xor_c,
            lambda: Z(self._mod, self._qis, q),
        )

        # X
        q = self._get_q(path[-1])
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

    def _xor(self, a: int, b: int):
        # return self._mod.builder.xor(self._mod.results[a], self._mod.results[b]) # TODO: xor
        return a

    def _bell_chain(
        self, path: Path, first: int, last: int, r1: int, r2: int
    ) -> None:  # Path length is always even
        r_prep = range(first + 1, last - 1, 2)
        r_meas = range(first, last + 1, 2)

        for i in r_prep:
            # Prepare BB
            q1 = self._get_q(path[i])
            q2 = self._get_q(path[i + 1])
            PrepareBB(self._mod, self._qis, q1, q2, self._q_ancilla)

        xs: list[int] = []
        zs: list[int] = []

        for i in r_meas:
            # Measure BB
            q1 = self._get_q(path[i])
            q2 = self._get_q(path[i + 1])
            xs.append(q1)
            zs.append(q2)
            MeasureBB(
                self._mod,
                self._qis,
                q1,
                q2,
                self._q_ancilla,
            )

        assert xs != []

        self._mod.results[r1] = self._mod.results[xs[0]]
        for x in xs[1:]:
            self._xor(r1, x)

        self._mod.results[r2] = self._mod.results[zs[0]]
        for z in zs[1:]:
            self._xor(r2, z)

    # Minimum number of qubits in a path is 3
    def _long_range_bell_prep(self, path: Path) -> None:  # Path length is always odd
        # Prepare BB at start
        q1 = self._get_q(path[0])
        q2 = self._get_q(path[1])
        PrepareBB(self._mod, self._qis, q1, q2, self._q_ancilla)

        x = self._r[0]
        z = self._r[1]

        if len(path) > 3:
            # Prepare BB at end
            q1 = self._get_q(path[-3])
            q2 = self._get_q(path[-2])
            PrepareBB(self._mod, self._qis, q1, q2, self._q_ancilla)

            # Bell chain
            self._bell_chain(path, 1, len(path) - 3, x, z)

        # Move
        frm = self._get_q(path[-2])
        to = self._get_q(path[-1])
        Move(self._mod, self._qis, frm, to, self._q_ancilla)

        if len(path) > 3:
            q = self._get_q(path[-1])

            # X
            self._qis.if_result(
                self._mod.results[z], lambda: X(self._mod, self._qis, q)
            )

            # Z
            self._qis.if_result(
                self._mod.results[x], lambda: Z(self._mod, self._qis, q)
            )

    # Minimum number of qubits in a path is 3
    def _long_range_bell_meas(
        self, path: Path
    ) -> tuple[int, int]:  # Path length is always odd
        # Move
        frm = flatten(
            *path[-1], self._grid_dims
        )  # TODO is the direction of the move correct, strange in paper?
        to = self._get_q(path[-2])
        Move(self._mod, self._qis, frm, to, self._q_ancilla)

        x = self._r[0]
        z = self._r[1]

        # Bell chain
        self._bell_chain(path, 0, len(path) - 2, x, z)

        return x, z

    def _long_range_X_prep_with_ZZ_meas(
        self, path: Path
    ) -> None:  # Path length is always even
        # Prepare X
        q = self._get_q(path[1])
        PrepareX(self._mod, self._qis, q)

        # Measure ZZ
        q1 = self._get_q(path[0])
        q2 = self._get_q(path[1])
        z_joint = self._r[0]
        MeasureZZ(self._mod, self._qis, q1, q2, self._q_ancilla, z_joint)

        # Prepare BB at end
        q1 = self._get_q(path[-2])
        q2 = self._get_q(path[-1])
        PrepareBB(self._mod, self._qis, q1, q2, self._q_ancilla)

        # Bell chain
        x = self._r[1]
        z_chain = self._r[2]
        self._bell_chain(path, 1, len(path) - 2, x, z_chain)
        # self._mod.results[z_chain] = self._mod.builder.xor(
        #     self._mod.results[z_chain], self._mod.results[z_joint]
        # )  # TODO: xor
        z = z_chain

        q = self._get_q(path[-1])

        # Z
        self._qis.if_result(self._mod.results[x], lambda: Z(self._mod, self._qis, q))

        # X
        self._qis.if_result(self._mod.results[z], lambda: X(self._mod, self._qis, q))

    def _long_range_Z_prep_with_XX_meas(
        self, path: Path
    ) -> None:  # Path length is always even
        # Prepare Z
        q = self._get_q(path[-2])
        PrepareZ(self._mod, self._qis, q)

        # Measure XX
        q1 = self._get_q(path[-2])
        q2 = self._get_q(path[-1])
        x_joint = self._r[0]
        MeasureXX(self._mod, self._qis, q1, q2, self._q_ancilla, x_joint)

        # Prepare BB at start
        q1 = self._get_q(path[0])
        q2 = self._get_q(path[1])
        PrepareBB(self._mod, self._qis, q1, q2, self._q_ancilla)

        # Bell chain
        x_chain = self._r[1]
        z = self._r[2]
        self._bell_chain(path, 1, len(path) - 2, x_chain, z)
        # self._mod.results[x_chain] = self._mod.builder.xor(self._mod.results[x_chain], self._mod.results[x_joint]) # TODO: xor
        x = x_chain

        q = self._get_q(path[0])

        # X
        self._qis.if_result(self._mod.results[z], lambda: X(self._mod, self._qis, q))

        # Z
        self._qis.if_result(self._mod.results[x], lambda: Z(self._mod, self._qis, q))

    def _long_range_teleport_with_ZZ_meas(
        self, path: Path
    ) -> None:  # Path length is always even
        # Prepare BB at start
        q1 = self._get_q(path[1])
        q2 = self._get_q(path[2])
        PrepareBB(self._mod, self._qis, q1, q2, self._q_ancilla)

        # Bell chain
        x_chain = self._r[0]
        z_chain = self._r[1]
        self._bell_chain(path, 2, len(path) - 2, x_chain, z_chain)

        # Measure ZZ
        q1 = self._get_q(path[0])
        q2 = self._get_q(path[1])
        z_joint = self._r[2]
        MeasureZZ(self._mod, self._qis, q1, q2, self._q_ancilla, z_joint)

        # Measure X
        q = self._get_q(path[1])
        x = self._r[3]
        MeasureX(self._mod, self._qis, q, x)

        # self._mod.results[x] = self._mod.builder.xor(
        #     self._mod.results[x], self._mod.results[x_chain]
        # )  # TODO: xor
        # self._mod.results[x] = self._mod.builder.xor(
        #     self._mod.results[x], self._mod.results[z_joint]
        # )
        # self._mod.results[x] = self._mod.builder.xor(
        #     self._mod.results[x], self._mod.results[z_chain]
        # )

        # Z
        q = self._get_q(path[0])
        self._qis.if_result(self._mod.results[x], lambda: Z(self._mod, self._qis, q))

    def _long_range_teleport_with_XX_meas(
        self, path: Path
    ) -> None:  # Path length is always even
        # Prepare BB at end
        q1 = self._get_q(path[-3])
        q2 = self._get_q(path[-2])
        PrepareBB(self._mod, self._qis, q1, q2, self._q_ancilla)

        # Bell chain
        x_chain = self._r[0]
        z_chain = self._r[1]
        self._bell_chain(path, 0, len(path) - 2, x_chain, z_chain)

        # Measure XX
        q1 = self._get_q(path[-2])
        q2 = self._get_q(path[-1])
        x_joint = self._r[2]
        MeasureXX(self._mod, self._qis, q1, q2, self._q_ancilla, x_joint)

        # Measure Z
        q = self._get_q(path[-2])
        z = self._r[3]
        MeasureZ(self._mod, self._qis, q, z)

        # self._mod.results[z] = self._mod.builder.xor(
        #     self._mod.results[z], self._mod.results[z_chain]
        # )  # TODO: xor
        # self._mod.results[z] = self._mod.builder.xor(
        #     self._mod.results[z], self._mod.results[x_joint]
        # )
        # self._mod.results[z] = self._mod.builder.xor(
        #     self._mod.results[z], self._mod.results[x_chain]
        # )

        # X
        q = self._get_q(path[-1])
        self._qis.if_result(self._mod.results[z], lambda: X(self._mod, self._qis, q))
