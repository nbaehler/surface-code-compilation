from path import Path, PathType
from helpers import flatten, is_data_qubit

import pyqir
import numpy as np

# Class the compiles a scheduling into a intermediate representation
class Compiler:
    def __init__(
        self,
        grid_dims: tuple[int, int],
        scheduling: list[list[Path]],
    ) -> None:
        self._grid_dims: tuple[int, int] = grid_dims
        self._scheduling: list[list[Path]] = scheduling

    # Compile into the intermediate representation
    def compile(self) -> str:
        n_qubits = np.prod(self._grid_dims, dtype=int)

        mod = pyqir.SimpleModule("Output", num_qubits=n_qubits, num_results=n_qubits)
        qis = pyqir.BasicQisBuilder(mod.builder)

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
        self, mod: pyqir.SimpleModule, qis: pyqir.BasicQisBuilder, path: Path
    ) -> None:
        self._long_range_bell_prep_1(mod, qis, path.interior())

        # Measure ZZ => b
        b: pyqir.Value = mod.results[0]
        # MeasureZZ(
        #     mod,
        #     qis,
        #     flatten(*path[0], self._grid_dims),
        #     flatten(*path[1], self._grid_dims),
        # )

        # Measure XX => a
        a: pyqir.Value = mod.results[1]
        # MeasureXX(
        #     mod,
        #     qis,
        #     flatten(*path[-2], self._grid_dims),
        #     flatten(*path[-1], self._grid_dims),
        # )

        # Measure X => c
        q = flatten(*path[1], self._grid_dims)
        c: pyqir.Value = mod.results[q]
        qis.h(mod.qubits[q])
        qis.mz(mod.qubits[q], c)

        # Measure Z => d
        q = flatten(*path[-2], self._grid_dims)
        d: pyqir.Value = mod.results[q]
        qis.mz(mod.qubits[q], d)

        a_xor_c = mod.builder.xor(a, c)
        b_xor_d = mod.builder.xor(b, d)

        # Z
        q = flatten(*path[0], self._grid_dims)
        qis.if_result(
            a_xor_c,
            one=lambda: qis.z(mod.qubits[q]),
            zero=lambda: None,
        )

        # X
        q = flatten(*path[-1], self._grid_dims)
        qis.if_result(
            b_xor_d,
            one=lambda: qis.x(mod.qubits[q]),
            zero=lambda: None,
        )

    def _compile_phase_1(
        self, mod: pyqir.SimpleModule, qis: pyqir.BasicQisBuilder, path: Path
    ) -> None:
        if is_data_qubit(path[0]):  # Control
            self._long_range_X_prep_with_ZZ_meas(mod, qis, path)
        elif is_data_qubit(path[-1]):  # Target
            self._long_range_Z_prep_with_XX_meas(mod, qis, path)
        else:
            self._long_range_bell_prep_2(mod, qis, path)

    def _compile_phase_2(
        self, mod: pyqir.SimpleModule, qis: pyqir.BasicQisBuilder, path: Path
    ) -> None:
        if is_data_qubit(path[0]):  # Control
            self._long_range_teleport_with_ZZ_meas(mod, qis, path)
        elif is_data_qubit(path[-1]):  # Target
            self._long_range_teleport_with_XX_meas(mod, qis, path)
        else:
            self._long_range_bell_meas(mod, qis, path)

    def _long_range_bell_prep_helper(
        self, mod: pyqir.SimpleModule, qis: pyqir.BasicQisBuilder, path: Path
    ) -> None:
        if len(path) % 2 == 1:
            end = len(path) - 2

            # Move
            # Move(
            #     mod,
            #     qis,
            #     flatten(*path[-2], self._grid_dims),
            #     flatten(*path[-1], self._grid_dims),
            # )
        else:
            end = len(path) - 1

        [
            # Prepare BB
            # PrepareBB(
            #     mod,
            #     qis,
            #     flatten(*path[i], self._grid_dims),
            #     flatten(*path[i + 1], self._grid_dims),
            # )
            # for i in range(0, end, 2)
        ]

        [
            # Measure BB
            # MeasureBB(
            #     mod,
            #     qis,
            #     flatten(*path[i], self._grid_dims),
            #     flatten(*path[i + 1], self._grid_dims),
            # )
            # for i in range(1, end - 1, 2)
        ]

    def _long_range_bell_prep_1(
        self, mod: pyqir.SimpleModule, qis: pyqir.BasicQisBuilder, path: Path
    ) -> None:
        self._long_range_bell_prep_helper(mod, qis, path)

        # Z
        qis.z(mod.qubits[flatten(*path[-1], self._grid_dims)])

        # X
        qis.x(mod.qubits[flatten(*path[-1], self._grid_dims)])

    def _long_range_bell_prep_2(
        self, mod: pyqir.SimpleModule, qis: pyqir.BasicQisBuilder, path: Path
    ) -> None:
        self._long_range_bell_prep_helper(mod, qis, path)

        # X
        qis.x(mod.qubits[flatten(*path[-1], self._grid_dims)])

        # Z
        qis.z(mod.qubits[flatten(*path[-1], self._grid_dims)])

    def _long_range_bell_meas(
        self, mod: pyqir.SimpleModule, qis: pyqir.BasicQisBuilder, path: Path
    ) -> None:
        if len(path) % 2 == 1:
            end = len(path) - 2

            # Move
            # Move(
            #     mod,
            #     qis,
            #     flatten(*path[-1], self._grid_dims),
            #     flatten(*path[-2], self._grid_dims),
            # )
        else:
            end = len(path) - 1

        [
            # Prepare BB
            # PrepareBB(
            #     mod,
            #     qis,
            #     flatten(*path[i], self._grid_dims),
            #     flatten(*path[i + 1], self._grid_dims),
            # )
            # for i in range(1, end - 1, 2)
        ]

        [
            # Measure BB
            # MeasureBB(
            #     mod,
            #     qis,
            #     flatten(*path[i], self._grid_dims),
            #     flatten(*path[i + 1], self._grid_dims),
            # )
            # for i in range(0, end, 2)
        ]

    def _long_range_X_prep_with_ZZ_meas(
        self, mod: pyqir.SimpleModule, qis: pyqir.BasicQisBuilder, path: Path
    ) -> None:
        # Prepare X
        qis.reset(mod.qubits[flatten(*path[1], self._grid_dims)])
        qis.h(mod.qubits[flatten(*path[1], self._grid_dims)])

        if len(path) % 2 == 1:
            end = len(path) - 1

            # Move
            # Move(
            #     mod,
            #     qis,
            #     flatten(*path[-2], self._grid_dims),
            #     flatten(*path[-1], self._grid_dims),
            # )

        else:
            end = len(path)

        [
            # Prepare BB
            # PrepareBB(
            #     mod,
            #     qis,
            #     flatten(*path[i], self._grid_dims),
            #     flatten(*path[i + 1], self._grid_dims),
            # )
            # for i in range(2, end, 2)
        ]

        # Measure ZZ
        # MeasureZZ(
        #     mod,
        #     qis,
        #     flatten(*path[0], self._grid_dims),
        #     flatten(*path[1], self._grid_dims),
        # )

        [
            # Measure BB
            # MeasureBB(
            #     mod,
            #     qis,
            #     flatten(*path[i], self._grid_dims),
            #     flatten(*path[i + 1], self._grid_dims),
            # )
            # for i in range(1, end - 1, 2)
        ]

        # X
        qis.x(mod.qubits[flatten(*path[-1], self._grid_dims)])

        # Z
        qis.z(mod.qubits[flatten(*path[-1], self._grid_dims)])

    def _long_range_Z_prep_with_XX_meas(
        self, mod: pyqir.SimpleModule, qis: pyqir.BasicQisBuilder, path: Path
    ) -> None:
        # Prepare Z
        qis.reset(mod.qubits[flatten(*path[-2], self._grid_dims)])

        if len(path) % 2 == 1:
            end = len(path) - 1

            # Move
            # Move(
            #     mod,
            #     qis,
            #     flatten(*path[-1], self._grid_dims),
            #     flatten(*path[-2], self._grid_dims),
            # )

        else:
            end = len(path)

        [
            # Prepare BB
            # PrepareBB(
            #     mod,
            #     qis,
            #     flatten(*path[i], self._grid_dims),
            #     flatten(*path[i + 1], self._grid_dims),
            # )
            # for i in range(0, end, 2)
        ]

        # Measure XX
        # MeasureXX(
        #     mod,
        #     qis,
        #     flatten(*path[-1], self._grid_dims),
        #     flatten(*path[-2], self._grid_dims),
        # )

        [
            # Measure BB
            # MeasureBB(
            #     mod,
            #     qis,
            #     flatten(*path[i], self._grid_dims),
            #     flatten(*path[i + 1], self._grid_dims),
            # )
            # for i in range(1, end - 1, 2)
        ]

        # X
        qis.x(mod.qubits[flatten(*path[0], self._grid_dims)])

        # Z
        qis.z(mod.qubits[flatten(*path[0], self._grid_dims)])

    def _long_range_teleport_with_ZZ_meas(
        self, mod: pyqir.SimpleModule, qis: pyqir.BasicQisBuilder, path: Path
    ) -> None:
        if len(path) % 2 == 1:
            end = len(path) - 2

            # Move
            # Move(
            #     mod,
            #     qis,
            #     flatten(*path[-1], self._grid_dims),
            #     flatten(*path[-2], self._grid_dims),
            # )
        else:
            end = len(path) - 1

        [
            # Prepare BB
            # PrepareBB(
            #     mod,
            #     qis,
            #     flatten(*path[i], self._grid_dims),
            #     flatten(*path[i + 1], self._grid_dims),
            # )
            # for i in range(1, end - 1, 2)
        ]

        [
            # Measure BB
            # MeasureBB(
            #     mod,
            #     qis,
            #     flatten(*path[i], self._grid_dims),
            #     flatten(*path[i + 1], self._grid_dims),
            # )
            # for i in range(2, end, 2)
        ]

        # Measure ZZ
        # MeasureZZ(
        #     mod,
        #     qis,
        #     flatten(*path[0], self._grid_dims),
        #     flatten(*path[1], self._grid_dims),
        # )

        # Measure X
        res = None
        qis.h(mod.qubits[flatten(*path[1], self._grid_dims)])
        qis.mz(mod.qubits[flatten(*path[1], self._grid_dims)], res)

        # Z
        qis.z(mod.qubits[flatten(*path[0], self._grid_dims)])

    def _long_range_teleport_with_XX_meas(
        self, mod: pyqir.SimpleModule, qis: pyqir.BasicQisBuilder, path: Path
    ) -> None:
        if len(path) % 2 == 1:
            end = len(path) - 1

            # Move
            # Move(
            #     mod,
            #     qis,
            #     flatten(*path[-2], self._grid_dims),
            #     flatten(*path[-1], self._grid_dims),
            # )

        else:
            end = len(path)

        [
            # Prepare BB
            # PrepareBB(
            #     mod,
            #     qis,
            #     flatten(*path[i], self._grid_dims),
            #     flatten(*path[i + 1], self._grid_dims),
            # )
            # for i in range(1, end - 1, 2)
        ]

        # Measure ZZ
        # MeasureZZ(
        #     mod,
        #     qis,
        #     flatten(*path[0], self._grid_dims),
        #     flatten(*path[1], self._grid_dims),
        # )

        [
            # Measure BB
            # MeasureBB(
            #     mod,
            #     qis,
            #     flatten(*path[i], self._grid_dims),
            #     flatten(*path[i + 1], self._grid_dims),
            # )
            # for i in range(0, end - 2, 2)
        ]

        # Measure XX
        # MeasureXX(
        #     mod,
        #     qis,
        #     flatten(*path[-2], self._grid_dims),
        #     flatten(*path[-1], self._grid_dims),
        # )

        # Measure Z
        res = None
        qis.mz(mod.qubits[flatten(*path[-2], self._grid_dims)], res)

        # Z
        qis.z(mod.qubits[flatten(*path[-1], self._grid_dims)])
