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
from helpers import flatten, is_data_qubit, append_dump_machine
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
        # Set up
        n_qubits: int = np.prod(self._grid_dims, dtype=int)

        self._mod = SimpleModule(
            "output", num_qubits=n_qubits + 1, num_results=n_qubits + 5
        )

        self._q_ancilla: int = n_qubits
        self._r: list[int] = list(range(n_qubits + 1, n_qubits + 5))
        self._qis = BasicQisBuilder(self._mod.builder)

        # Compile all the epochs in the scheduling
        for epoch in self._scheduling:
            # Compile all the paths in the epoch
            for path in epoch:
                if path.get_type() == PathType.LONG_RANGE_CNOT:
                    self._compile_long_range_cnot(path)
                elif path.get_type() == PathType.PHASE_1:
                    self._compile_phase_1(path)
                else:  # path.get_type() == PathType.PHASE_2:
                    self._compile_phase_2(path)

        # Reset all the ancilla qubits as their state is not of interest and
        # hence don't need to be output by the simulator
        for i in range(self._grid_dims[0]):
            for j in range(self._grid_dims[1]):
                if not is_data_qubit((i, j)):
                    q = self._get_q((i, j))
                    self._qis.reset(self._mod.qubits[q])

        # Append some code to the module that allows to simulator to output the
        # entire state of the qubits
        append_dump_machine(self._mod)

        # Return the qir
        return self._mod.ir()

    # Compute the flat index of a qubit
    def _get_q(self, vertex_idx: tuple[int, int]) -> int:
        return flatten(*vertex_idx, self._grid_dims)

    # Compile a long range cnot, which is not split into two phases. Minimum
    # number of qubits in the path is 5
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

        # Z
        q = self._get_q(path[0])
        self._qis.if_result(
            self._mod.results[a],
            lambda: Z(self._mod, self._qis, q),
        )

        self._qis.if_result(
            self._mod.results[c],
            lambda: Z(self._mod, self._qis, q),
        )

        # X
        q = self._get_q(path[-1])
        self._qis.if_result(
            self._mod.results[b],
            lambda: X(self._mod, self._qis, q),
        )

        self._qis.if_result(
            self._mod.results[d],
            lambda: X(self._mod, self._qis, q),
        )

    # Compile a phase 1 path
    def _compile_phase_1(self, path: Path) -> None:
        if is_data_qubit(path[0]):  # Control
            self._long_range_X_prep_with_ZZ_meas(path)
        elif is_data_qubit(path[-1]):  # Target
            self._long_range_Z_prep_with_XX_meas(path)
        else:
            self._long_range_bell_prep(path)

    # Compile a phase 2 path
    def _compile_phase_2(self, path: Path) -> None:
        if is_data_qubit(path[0]):  # Control
            self._long_range_teleport_with_ZZ_meas(path)
        elif is_data_qubit(path[-1]):  # Target
            self._long_range_teleport_with_XX_meas(path)
        else:
            self._long_range_bell_meas(path)

    # Compile a Bell chain. Path length is always even
    def _bell_chain(
        self,
        path: Path,
        first: int,
        last: int,
    ) -> tuple[list[int], list[int]]:
        # Define ranges
        r_prep = range(first + 1, last - 1, 2)
        r_meas = range(first, last + 1, 2)

        # Assert that the range for the me
        assert r_meas

        # Prepare BB
        for i in r_prep:
            q1 = self._get_q(path[i])
            q2 = self._get_q(path[i + 1])
            PrepareBB(self._mod, self._qis, q1, q2, self._q_ancilla)

        xs: list[int] = []
        zs: list[int] = []

        # Measure BB
        for i in r_meas:
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

        return xs, zs

    # Compile a long range Bell preparation. Minimum number of qubits in a path
    # is 3. Path length is always odd
    def _long_range_bell_prep(self, path: Path) -> None:
        # Prepare BB at start
        q1 = self._get_q(path[0])
        q2 = self._get_q(path[1])
        PrepareBB(self._mod, self._qis, q1, q2, self._q_ancilla)

        if len(path) > 3:
            # Prepare BB at end
            q1 = self._get_q(path[-3])
            q2 = self._get_q(path[-2])
            PrepareBB(self._mod, self._qis, q1, q2, self._q_ancilla)

            # Bell chain
            xs, zs = self._bell_chain(path, 1, len(path) - 3)

        # Move
        frm = self._get_q(path[-2])
        to = self._get_q(path[-1])
        Move(self._mod, self._qis, frm, to, self._q_ancilla)

        if len(path) > 3:
            q = self._get_q(path[-1])

            # X
            for z in zs:
                self._qis.if_result(
                    self._mod.results[z], lambda: X(self._mod, self._qis, q)
                )

            # Z
            for x in xs:
                self._qis.if_result(
                    self._mod.results[x], lambda: Z(self._mod, self._qis, q)
                )

    # Compile a long range Bell measurement. Minimum number of qubits in a path
    # is 3. Path length is always odd
    def _long_range_bell_meas(self, path: Path) -> tuple[list[int], list[int]]:
        # Move
        frm = flatten(
            *path[-1], self._grid_dims
        )  # TODO is the direction of the move correct, strange in paper?
        to = self._get_q(path[-2])
        Move(self._mod, self._qis, frm, to, self._q_ancilla)

        # Bell chain
        return self._bell_chain(path, 0, len(path) - 2)

    # Compile a long range X preparation with ZZ measurement. Path length is always even
    def _long_range_X_prep_with_ZZ_meas(self, path: Path) -> None:
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
        xs, zs = self._bell_chain(path, 1, len(path) - 2)

        q = self._get_q(path[-1])

        # Z
        for x in xs:
            self._qis.if_result(
                self._mod.results[x], lambda: Z(self._mod, self._qis, q)
            )

        # X
        for z in zs + [z_joint]:
            self._qis.if_result(
                self._mod.results[z], lambda: X(self._mod, self._qis, q)
            )

    # Compile a long range Z preparation with XX measurement. Path length is always even
    def _long_range_Z_prep_with_XX_meas(self, path: Path) -> None:
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
        xs, zs = self._bell_chain(path, 1, len(path) - 2)

        q = self._get_q(path[0])

        # X
        for z in zs:
            self._qis.if_result(
                self._mod.results[z], lambda: X(self._mod, self._qis, q)
            )

        # Z
        for x in xs + [x_joint]:
            self._qis.if_result(
                self._mod.results[x], lambda: Z(self._mod, self._qis, q)
            )

    # Compile a long range teleportation with ZZ measurement. Path length is always even
    def _long_range_teleport_with_ZZ_meas(self, path: Path) -> None:
        # Prepare BB at start
        q1 = self._get_q(path[1])
        q2 = self._get_q(path[2])
        PrepareBB(self._mod, self._qis, q1, q2, self._q_ancilla)

        # Bell chain
        xs, zs = self._bell_chain(path, 2, len(path) - 2)

        # Measure ZZ
        q1 = self._get_q(path[0])
        q2 = self._get_q(path[1])
        z_joint = self._r[2]
        MeasureZZ(self._mod, self._qis, q1, q2, self._q_ancilla, z_joint)

        # Measure X
        q = self._get_q(path[1])
        x = self._r[3]
        MeasureX(self._mod, self._qis, q, x)

        # Z
        q = self._get_q(path[0])

        for a in xs + [x] + zs + [z_joint]:
            self._qis.if_result(
                self._mod.results[a], lambda: Z(self._mod, self._qis, q)
            )

    # Compile a long range teleportation with XX measurement. Path length is always even
    def _long_range_teleport_with_XX_meas(self, path: Path) -> None:
        # Prepare BB at end
        q1 = self._get_q(path[-3])
        q2 = self._get_q(path[-2])
        PrepareBB(self._mod, self._qis, q1, q2, self._q_ancilla)

        # Bell chain
        xs, zs = self._bell_chain(path, 0, len(path) - 2)

        # TODO compute "xor" directly here, those results might get overwritten
        # in the meantime

        # Measure XX
        q1 = self._get_q(path[-2])
        q2 = self._get_q(path[-1])
        x_joint = self._r[2]
        MeasureXX(self._mod, self._qis, q1, q2, self._q_ancilla, x_joint)

        # Measure Z
        q = self._get_q(path[-2])
        z = self._r[3]
        MeasureZ(self._mod, self._qis, q, z)

        # X
        q = self._get_q(path[-1])

        for a in xs + [x_joint] + zs + [z]:
            self._qis.if_result(
                self._mod.results[a], lambda: X(self._mod, self._qis, q)
            )
