import itertools
from abc import ABC

from helpers import is_data_qubit


class Path(ABC):
    def __init__(self) -> None:
        self._vertices = []

    def __getitem__(self, i: int) -> tuple[int, int]:
        if i < 0:
            i += len(self)

        if i < 0 or i >= len(self):
            raise IndexError(f"Index {i} out of range for path of length {len(self)}")

        return self._vertices[i]

    def __len__(self) -> int:
        return len(self._vertices)


class CompletePath(Path):
    def __init__(self, vertices: list[tuple[int, int]] = None) -> None:
        super().__init__()

        self._vertices = [] if vertices is None else vertices

    def add_vertex(self, vertex: tuple[int, int]) -> None:
        self._vertices.append(vertex)

    def reverse(self) -> None:
        self._vertices.reverse()

    def get_vertices(self) -> list[tuple[int, int]]:
        return self._vertices


class KeyPath(Path):
    def __init__(self) -> None:
        super().__init__()

    def to_complete_path(self) -> CompletePath:
        path = CompletePath()

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

    def is_vertex_disjoint(self, other: KeyPath) -> bool:
        first = set(self.to_complete_path().get_vertices())  # TODO inefficient?
        second = set(other.to_complete_path().get_vertices())

        return not first.intersection(second)

    def is_edge_disjoint(self, other: KeyPath) -> bool:
        first = self.to_complete_path().get_vertices()
        second = other.to_complete_path().get_vertices()

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
