from gate import (
    Gate,
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
    def compile(self) -> list[list[list[list[Gate]]]]:
        ir = []
        for epoch in self._scheduling:
            epoch_ir = []
            for path in epoch:
                if path.get_type() == PathType.LONG_RANGE_CNOT:
                    epoch_ir.append(self._compile_long_range_cnot(path))
                elif path.get_type() == PathType.PHASE_1:
                    epoch_ir.append(self._compile_phase_1(path))
                else:  # path.get_type() == PathType.PHASE_2:
                    epoch_ir.append(self._compile_phase_2(path))

            ir.append(epoch_ir)

        return ir

    def _compile_long_range_cnot(self, path: Path) -> list[list[Gate]]:
        phases = self._long_range_bell_prep_1(
            path.interior()
        )  # TODO Can I run the ZZ and XX in parallel with the BB meas? Aka need Z, X in bell prep?
        phases.extend(
            [
                [
                    MeasureZZ(
                        flatten(*path[0], self._grid_dims),
                        flatten(*path[1], self._grid_dims),
                    ),
                    MeasureXX(
                        flatten(*path[-2], self._grid_dims),
                        flatten(*path[-1], self._grid_dims),
                    ),
                ],
                [
                    MeasureX(flatten(*path[1], self._grid_dims)),
                    MeasureZ(flatten(*path[-2], self._grid_dims)),
                ],
                [
                    Z(flatten(*path[0], self._grid_dims)),
                    X(flatten(*path[-1], self._grid_dims)),
                ],
            ]
        )

        return phases

    def _compile_phase_1(self, path: Path) -> list[list[list[Gate]]]:
        if is_data_qubit(path[0]):  # Control
            return [self._long_range_X_prep_with_ZZ_meas(path)]
        elif is_data_qubit(path[-1]):  # Target
            return [self._long_range_Z_prep_with_XX_meas(path)]
        else:
            return [self._long_range_bell_prep_2(path)]

    def _compile_phase_2(self, path: Path) -> list[list[list[Gate]]]:
        if is_data_qubit(path[0]):  # Control
            return [self._long_range_teleport_with_ZZ_meas(path)]
        elif is_data_qubit(path[-1]):  # Target
            return [self._long_range_teleport_with_XX_meas(path)]
        else:
            return [self._long_range_bell_meas(path)]

    def _long_range_bell_prep_helper(self, path: Path) -> list[list[Gate]]:
        bell_meas = []

        if len(path) % 2 == 1:
            end = len(path) - 2

            bell_meas.append(
                Move(
                    flatten(*path[-2], self._grid_dims),
                    flatten(*path[-1], self._grid_dims),
                )
            )
        else:
            end = len(path) - 1

        bell_preps = [
            PrepareBB(
                flatten(*path[i], self._grid_dims),
                flatten(*path[i + 1], self._grid_dims),
            )
            for i in range(0, end, 2)
        ]

        bell_meas.extend(
            [
                MeasureBB(
                    flatten(*path[i], self._grid_dims),
                    flatten(*path[i + 1], self._grid_dims),
                )
                for i in range(1, end - 1, 2)
            ]
        )

        return [bell_preps, bell_meas]

    def _long_range_bell_prep_1(self, path: Path) -> list[list[Gate]]:
        return [
            *self._long_range_bell_prep_helper(path),
            [Z(flatten(*path[-1], self._grid_dims))],
            [X(flatten(*path[-1], self._grid_dims))],
        ]

    def _long_range_bell_prep_2(self, path: Path) -> list[list[Gate]]:
        return [
            *self._long_range_bell_prep_helper(path),
            [X(flatten(*path[-1], self._grid_dims))],
            [Z(flatten(*path[-1], self._grid_dims))],
        ]

    def _long_range_bell_meas(self, path: Path) -> list[list[Gate]]:
        bell_preps = []

        if len(path) % 2 == 1:
            end = len(path) - 2

            bell_preps.append(
                Move(
                    flatten(*path[-1], self._grid_dims),
                    flatten(*path[-2], self._grid_dims),
                )
            )
        else:
            end = len(path) - 1

        bell_preps.extend(
            [
                PrepareBB(
                    flatten(*path[i], self._grid_dims),
                    flatten(*path[i + 1], self._grid_dims),
                )
                for i in range(1, end - 1, 2)
            ]
        )

        bell_meas = [
            MeasureBB(
                flatten(*path[i], self._grid_dims),
                flatten(*path[i + 1], self._grid_dims),
            )
            for i in range(0, end, 2)
        ]

        return [
            bell_preps,
            bell_meas,
        ]

    def _long_range_X_prep_with_ZZ_meas(self, path: Path) -> list[list[Gate]]:
        bell_meas = []

        if len(path) % 2 == 1:
            end = len(path) - 1

            bell_meas.append(  # TODO how???
                Move(
                    flatten(*path[-2], self._grid_dims),
                    flatten(*path[-1], self._grid_dims),
                )
            )
        else:
            end = len(path)

        bell_preps: list[Gate] = [
            PrepareBB(
                flatten(*path[i], self._grid_dims),
                flatten(*path[i + 1], self._grid_dims),
            )
            for i in range(2, end, 2)
        ]

        bell_preps.append(
            MeasureZZ(
                flatten(*path[0], self._grid_dims), flatten(*path[1], self._grid_dims)
            )
        )

        bell_meas.extend(
            [
                MeasureBB(
                    flatten(*path[i], self._grid_dims),
                    flatten(*path[i + 1], self._grid_dims),
                )
                for i in range(1, end - 1, 2)
            ]
        )

        return [
            [PrepareX(flatten(*path[1], self._grid_dims))],
            bell_preps,
            bell_meas,
            [X(flatten(*path[-1], self._grid_dims))],
            [Z(flatten(*path[-1], self._grid_dims))],
        ]

    def _long_range_Z_prep_with_XX_meas(self, path: Path) -> list[list[Gate]]:
        bell_preps = []

        if len(path) % 2 == 1:
            end = len(path) - 1

            bell_preps.append(  # TODO how???
                Move(
                    flatten(*path[-1], self._grid_dims),
                    flatten(*path[-2], self._grid_dims),
                )
            )
        else:
            end = len(path)

        bell_preps.extend(
            [
                PrepareBB(
                    flatten(*path[i], self._grid_dims),
                    flatten(*path[i + 1], self._grid_dims),
                )
                for i in range(0, end, 2)
            ]
        )

        bell_preps.append(
            MeasureXX(
                flatten(*path[-1], self._grid_dims), flatten(*path[-2], self._grid_dims)
            )
        )

        bell_meas = [
            MeasureBB(
                flatten(*path[i], self._grid_dims),
                flatten(*path[i + 1], self._grid_dims),
            )
            for i in range(1, end - 1, 2)
        ]

        return [
            [PrepareZ(flatten(*path[-2], self._grid_dims))],
            bell_preps,
            bell_meas,
            [X(flatten(*path[0], self._grid_dims))],
            [Z(flatten(*path[0], self._grid_dims))],
        ]

    def _long_range_teleport_with_ZZ_meas(self, path: Path) -> list[list[Gate]]:
        bell_preps = []

        if len(path) % 2 == 1:
            end = len(path) - 2

            bell_preps.append(  # TODO how???
                Move(
                    flatten(*path[-1], self._grid_dims),
                    flatten(*path[-2], self._grid_dims),
                )
            )
        else:
            end = len(path) - 1

        bell_preps.extend(
            [
                PrepareBB(
                    flatten(*path[i], self._grid_dims),
                    flatten(*path[i + 1], self._grid_dims),
                )
                for i in range(1, end - 1, 2)
            ]
        )

        bell_meas = [
            MeasureBB(
                flatten(*path[i], self._grid_dims),
                flatten(*path[i + 1], self._grid_dims),
            )
            for i in range(2, end, 2)
        ]

        bell_meas.append(
            MeasureZZ(
                flatten(*path[0], self._grid_dims), flatten(*path[1], self._grid_dims)
            )
        )

        return [
            bell_preps,
            bell_meas,
            [MeasureX(flatten(*path[1], self._grid_dims))],
            [Z(flatten(*path[0], self._grid_dims))],
        ]

    def _long_range_teleport_with_XX_meas(self, path: Path) -> list[list[Gate]]:
        bell_meas = []

        if len(path) % 2 == 1:
            end = len(path) - 1

            bell_meas.append(  # TODO how???
                Move(
                    flatten(*path[-2], self._grid_dims),
                    flatten(*path[-1], self._grid_dims),
                )
            )
        else:
            end = len(path)

        bell_preps: list[Gate] = [
            PrepareBB(
                flatten(*path[i], self._grid_dims),
                flatten(*path[i + 1], self._grid_dims),
            )
            for i in range(1, end - 1, 2)
        ]

        bell_preps.append(
            MeasureZZ(
                flatten(*path[0], self._grid_dims), flatten(*path[1], self._grid_dims)
            )
        )

        bell_meas.extend(
            [
                MeasureBB(
                    flatten(*path[i], self._grid_dims),
                    flatten(*path[i + 1], self._grid_dims),
                )
                for i in range(0, end - 2, 2)
            ]
        )

        bell_meas.append(
            MeasureXX(
                flatten(*path[-2], self._grid_dims), flatten(*path[-1], self._grid_dims)
            )
        )

        return [
            bell_preps,
            bell_meas,
            [MeasureZ(flatten(*path[-2], self._grid_dims))],
            [X(flatten(*path[-1], self._grid_dims))],
        ]
