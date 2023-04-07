import numpy as np
from path import Path

# TODO replace list[Path] by Phase ?


class Epoch:
    def __init__(
        self,
        paths: list[Path],
        phase_1: list[Path] = None,
        phase_2: list[Path] = None,
    ) -> None:
        if not phase_1:
            phase_1 = []

        if not phase_2:
            phase_2 = []

        self._paths = paths  # TODO __ double underscore?
        self._phase_1 = phase_1
        self._phase_2 = phase_2

    # Length
    def __len__(self) -> int:
        return int(self._paths != [] or self._phase_1 != []) + int(self._phase_2 != [])

    # String
    def __str__(self) -> str:
        p = self._paths
        p += self._phase_1

        s = "Phase 1:\n" + ",\n".join(
            [f"Path {i+1}: {path}" for i, path in enumerate(p)]
        )

        if self._phase_2:
            s += "\nPhase 2:\n" + ",\n".join(
                [f"Path {i+1}: {path}" for i, path in enumerate(self._phase_2)]
            )

        return s

    # # Iterator # TODO needed?
    # def __iter__(self):
    #     return EpochIterator(self)

    def append_path(self, path: Path):
        self._paths.append(path)

    # Find the vertex disjoint paths in the given operator EDP set, the
    # remaining paths are subsequently split into two operator VDP sets
    def edp_subroutine(
        self,
    ) -> None:
        # For each path pair check if they are vertex disjoint
        paths_to_split_idx = {}
        for i in range(len(self._paths)):
            for j in range(i + 1, len(self._paths)):
                current_crossing_vertices = self._paths[i].crossing_vertices(
                    self._paths[j]
                )

                # If not, keep track of the path and the crossing vertices
                if current_crossing_vertices != set():
                    if i in paths_to_split_idx:
                        paths_to_split_idx[i].update(
                            paths_to_split_idx[i].union(current_crossing_vertices)
                        )
                    else:
                        paths_to_split_idx[i] = set(current_crossing_vertices)

        # When the operator EDP set is not vertex disjoint, fragment it into
        # two operator VDP sets
        if paths_to_split_idx != {}:
            self.__fragment_edp_set(paths_to_split_idx)

    # Given the intersecting paths and the crossing vertices, fragment the
    # operator EDP set into two operator VDP sets
    def __fragment_edp_set(
        self,
        paths_to_split_idx: dict[int, set[tuple[int, int]]],
    ) -> None:
        # Get the indices of the vertex disjoint paths
        vertex_disjoint_path_idx = [
            i for i in range(len(self._paths)) if i not in paths_to_split_idx
        ]

        # Remove the non vertex disjoint paths from the list of paths
        self._phase_1 = [self._paths[i] for i in vertex_disjoint_path_idx]

        # Split the remaining paths into two phases
        for i, crossing_vertices in paths_to_split_idx.items():
            current_path = self._paths[i]
            phases = [1] * len(current_path)

            # Match up the crossing vertices to the second phase with the
            # required vertex before and after the crossing vertex itself
            for j, vertex in enumerate(current_path):
                if vertex in crossing_vertices:
                    assert j > 0 and j < len(current_path) - 1
                    phases[j - 1] = 2
                    phases[j] = 2
                    phases[j + 1] = 2

            phases_1_vertices = []
            phases_2_vertices = []

            # Attribute the vertices to the phases
            last = phases[0]
            for j, p in enumerate(phases):
                # Transition from phase 1 to phase 2
                if p > last:
                    phases_1_vertices.append(current_path[j])
                    phases_2_vertices.append(current_path[j])
                # Transition from phase 2 to phase 1
                elif p < last:
                    phases_1_vertices.extend((current_path[j - 1], current_path[j]))
                # Stay in the phase 1
                elif p == 1:
                    phases_1_vertices.append(current_path[j])
                # Stay in the phase 2
                else:
                    phases_2_vertices.append(current_path[j])

                last = p

            # Create two new paths for the two phases while maintaining the same
            # id
            current_id = current_path.get_path_id()

            path = Path(current_id, phases_1_vertices)
            self._phase_1.append(path)

            assert len(phases_1_vertices) > 1

            path = Path(current_id, phases_2_vertices)
            self._phase_2.append(path)

            assert len(phases_2_vertices) > 1

        self._paths = []

    def get_phases(self) -> list[list[Path]]:
        if self._phase_1 == []:
            assert self._phase_2 == []
            return [self._paths]

        assert self._phase_1 != []
        assert self._phase_2 != []

        return [self._phase_1, self._phase_2]

    def edge_disjoint(self) -> bool:
        paths = self._paths

        for i in range(len(paths)):
            for j in range(i + 1, len(paths)):
                if not paths[i].is_edge_disjoint(paths[j]) or not paths[
                    i
                ].is_terminal_disjoint(paths[j]):
                    return False

        return True


# # Iterator over the phases of the epoch # TODO needed?
# class EpochIterator:
#     def __init__(self, epoch: Epoch) -> None:
#         self._index = 0
#         self._epoch = epoch

#     def __iter__(self):
#         return self

#     def __next__(self) -> list[Path]:
#         if self._index == 0:
#             self._index += 1
#             return self._epoch._paths + self._epoch._phase_1
#         if self._index == 1:
#             self._index += 1
#             return self._epoch._phase_2

#         raise StopIteration


# ==============================================================================
# TODO create a scheduling class?? Put those two functions in there


def get_length_of_scheduling(
    scheduling: list[Epoch],
) -> int:
    return np.sum([len(epoch) for epoch in scheduling])


def get_phases_of_scheduling(
    scheduling: list[Epoch],
) -> list[list[Path]]:
    phases = []
    for epoch in scheduling:
        phases.extend(phase for phase in epoch.get_phases() if phase != [[]])

    return phases or [[]]


def print_scheduling(scheduling: list[Epoch]) -> None:
    print(
        "Scheduling:\n"
        + ",\n".join(
            [
                ",\n".join([f"Epoch {i+1}:\n{epoch}"])
                for i, epoch in enumerate(scheduling)
            ]
        )
    )


def print_phases(scheduling: list[Epoch]):
    print(
        "Phases:\n"
        + ",\n".join(
            [
                ",\n".join(
                    [
                        f"Phase {i+1}:\n"
                        + ",\n".join(
                            [f"Path {j+1}: {path}" for j, path in enumerate(phase)]
                        )
                        for i, phase in enumerate(get_phases_of_scheduling(scheduling))
                    ]
                )
            ]
        )
    )


def epochs_edge_disjoint(scheduling: list[Epoch]) -> bool:
    return all(item.edge_disjoint() for item in scheduling)


def phases_vertex_disjoint(scheduling: list[Epoch]) -> bool:
    phases = get_phases_of_scheduling(scheduling)
    for phase in phases:
        qubits = set()
        for path in phase:
            if qubits.intersection(path._vertices) != set():
                return False
            else:
                qubits = qubits.union(path._vertices)

    return True
