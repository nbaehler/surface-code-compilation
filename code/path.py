from __future__ import annotations

import itertools
from abc import ABC
from enum import Enum

from helpers import is_data_qubit


class PathType(Enum):
    LONG_RANGE_CNOT = 0
    PHASE_1 = 1
    PHASE_2 = 2


class Path(ABC):
    def __init__(
        self,
        type: PathType = None,
        vertices: list[tuple[int, int]] = None,
    ) -> None:
        super().__init__()

        self._vertices = [] if vertices is None else vertices
        self._type = PathType.LONG_RANGE_CNOT if type is None else type

    def __getitem__(self, i: int) -> tuple[int, int]:
        if i < 0:
            i += len(self)

        if i < 0 or i >= len(self):
            raise IndexError(f"Index {i} out of range for path of length {len(self)}")

        return self._vertices[i]

    def __len__(self) -> int:
        return len(self._vertices)

    def add_vertex(self, vertex: tuple[int, int]) -> None:
        self._vertices.append(vertex)

    def reverse(self) -> None:
        self._vertices.reverse()

    def is_vertex_disjoint(self, other: Path) -> bool:
        return not set(self._vertices).intersection(
            set(other._vertices)
        )  # TODO inefficient?

    def split(  # TODO does this guarantee that the split paths are disjoint?
        self, split_vertices: list[tuple[int, int]]
    ) -> tuple[list[Path], list[Path]]:
        p1, p2 = [], []

        indices = [self._vertices.index(v) for v in split_vertices]
        indices.sort()

        phase = False
        start = 0
        for split_index in indices:
            if not phase:
                p1.append(Path(PathType.PHASE_1, self._vertices[start:split_index]))
            else:
                p2.append(Path(PathType.PHASE_2, self._vertices[start:split_index]))

            start = split_index - 1
            phase = not phase

        if not phase:
            p1.append(Path(PathType.PHASE_1, self._vertices[start:]))
        else:
            p2.append(Path(PathType.PHASE_2, self._vertices[start:]))

        return p1, p2


class KeyPath(Path):
    def __init__(self) -> None:
        super().__init__()

    def extend_to_path(self) -> Path:
        path = Path(self._type)

        path.add_vertex(self._vertices[0])

        step = 1 if self._vertices[1][1] < self._vertices[2][1] else -1
        for i in range(self._vertices[1][1], self._vertices[2][1], step):
            path.add_vertex((self._vertices[1][0], i))

        step = 1 if self._vertices[2][0] < self._vertices[3][0] else -1
        for i in range(self._vertices[2][0], self._vertices[3][0], step):
            path.add_vertex((i, self._vertices[2][1]))

        path.add_vertex(self._vertices[3])
        path.add_vertex(self._vertices[4])

        return path


class PaperKeyPath(KeyPath):
    def __init__(self, start: tuple[int, int], stop: tuple[int, int]) -> None:
        super().__init__()

        assert is_data_qubit(start)
        assert is_data_qubit(stop)

        start_r, start_c = start
        stop_r, stop_c = stop

        self._vertices = [  # TODO They are not consistent in the paper, the use this path scheme in proofs but then use different ones in the graphics
            (start_r, start_c),
            (start_r - 1, start_c),
            (start_r - 1, stop_c - 1),
            (stop_r, stop_c - 1),
            (stop_r, stop_c),
        ]

    def is_edge_disjoint(self, other: PaperKeyPath) -> bool:
        first = self._vertices
        second = other._vertices

        return any(  # TODO inefficient
            first[i] == second[j] and first[i + 1] == second[j + 1]
            for i, j in itertools.product(range(len(first) - 1), range(len(second) - 1))
        )


class DirectKeyPath(KeyPath):
    def __init__(self, start: tuple[int, int], stop: tuple[int, int]) -> None:
        super().__init__()

        start_r, start_c = start
        stop_r, stop_c = stop

        current_r = start_r
        current_c = start_c
        self._vertices = [(current_r, current_c)]

        if current_r > stop_r:  # Start -> vertical
            current_r -= 1
        else:
            current_r += 1
        self._vertices.append((current_r, current_c))

        if current_c > stop_c:
            current_c -= current_c - (stop_c + 1)
        else:
            current_c += (stop_c - 1) - current_c
        self._vertices.append((current_r, current_c))

        current_r -= current_r - stop_r if current_r > stop_r else stop_r - current_r
        self._vertices.append((current_r, current_c))

        if current_c > stop_c:  # End -> horizontal
            current_c -= 1
        else:
            current_c += 1
        self._vertices.append((current_r, current_c))

        assert current_r == stop_r and current_c == stop_c
