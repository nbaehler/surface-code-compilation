from __future__ import annotations

import itertools
from enum import Enum
from abc import abstractmethod

from helpers import is_data_qubit

# Enum for the different types of paths for compilation
class PathType(Enum):
    LONG_RANGE_CNOT = 0
    PHASE_1 = 1
    PHASE_2 = 2


# Class modelling a path containing all vertices in the operator graph
class Path:
    def __init__(
        self,
        type: PathType = None,
        vertices: list[tuple[int, int]] = None,
    ) -> None:
        super().__init__()

        self._vertices = [] if vertices is None else vertices
        self._type = PathType.LONG_RANGE_CNOT if type is None else type

    # Getter
    def __getitem__(self, i: int) -> tuple[int, int]:
        # Wrap around, allows -1 for last element etc.
        if i < 0:
            i += len(self)

        if i < 0 or i >= len(self):
            raise IndexError(f"Index {i} out of range for path of length {len(self)}")

        return self._vertices[i]

    # Length
    def __len__(self) -> int:
        return len(self._vertices)

    # String
    def __str__(self) -> str:
        return str(self._vertices)

    # Append a vertex to the path
    def append_vertex(self, vertex: tuple[int, int]) -> None:
        self._vertices.append(vertex)

    # Reverse the path
    def reverse(self) -> None:
        self._vertices.reverse()

    # Return the set of crossing vertices between two paths
    def crossing_vertices(self, other: Path) -> set[tuple[int, int]]:
        return set(self._vertices).intersection(set(other._vertices))

    # Check if the path is edge-disjoint from another path
    def is_edge_disjoint(self, other: Path) -> bool:
        first = self._vertices
        second = other._vertices

        # Check if any pair of edges are equal
        e1 = {tuple(first[i : i + 2]) for i in range(len(first) - 1)}
        e2 = {tuple(second[i : i + 2]) for i in range(len(second) - 1)}

        return not e1.intersection(e2)

    # Split the path into several paths at the given vertices
    def split(  # TODO does this guarantee that the split paths are disjoint? Iterate over all crossing, label in both directions accordingly, ig a violation occurs we have a problem
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


# Class for paths that are denoted using only key vertices on that path
class KeyPath(Path):
    def __init__(self) -> None:
        super().__init__()

    # Extend the KeyPath to a normal Path i.e. fill in the missing vertices
    def extend_to_path(self) -> Path:
        path = Path(self._type)

        # Add start vertex
        path.append_vertex(self._vertices[0])

        # Add all vertices in between, horizontally
        step = 1 if self._vertices[1][1] < self._vertices[2][1] else -1
        for i in range(self._vertices[1][1], self._vertices[2][1], step):
            path.append_vertex((self._vertices[1][0], i))

        # Add all vertices in between, vertically
        step = 1 if self._vertices[2][0] < self._vertices[3][0] else -1
        for i in range(self._vertices[2][0], self._vertices[3][0], step):
            path.append_vertex((i, self._vertices[2][1]))

        # Add last to vertices
        path.append_vertex(self._vertices[3])
        path.append_vertex(self._vertices[4])

        return path

    @abstractmethod
    def is_edge_disjoint(self, other: KeyPath) -> bool:
        pass


# Class for KeyPaths that are described in the paper
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

    # Check if the path is edge-disjoint from another path
    def is_edge_disjoint(
        self, other: PaperKeyPath
    ) -> bool:  # TODO more efficient, direct way
        return self.extend_to_path().is_edge_disjoint(other.extend_to_path())


# Class for KeyPaths that are optimized in the sense that they are shorter than the paths described in the paper
class DirectKeyPath(KeyPath):
    def __init__(self, start: tuple[int, int], stop: tuple[int, int]) -> None:
        super().__init__()

        start_r, start_c = start
        stop_r, stop_c = stop

        current_r = start_r
        current_c = start_c

        # Start
        self._vertices = [(current_r, current_c)]

        # Vertical step
        if current_r > stop_r:
            current_r -= 1
        else:
            current_r += 1
        self._vertices.append((current_r, current_c))

        # Horizontal steps
        if current_c > stop_c:
            current_c -= current_c - (stop_c + 1)
        else:
            current_c += (stop_c - 1) - current_c
        self._vertices.append((current_r, current_c))

        # Vertical steps
        current_r -= current_r - stop_r if current_r > stop_r else stop_r - current_r
        self._vertices.append((current_r, current_c))

        # Horizontal step
        if current_c > stop_c:  # End -> horizontal
            current_c -= 1
        else:
            current_c += 1
        self._vertices.append((current_r, current_c))

        # End
        assert current_r == stop_r and current_c == stop_c

    def is_edge_disjoint(
        self, other: PaperKeyPath
    ) -> bool:  # TODO more efficient, direct way
        return self.extend_to_path().is_edge_disjoint(other.extend_to_path())
