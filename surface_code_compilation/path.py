from __future__ import annotations

from enum import Enum

from helpers import compute_equivalent_letter, is_data_qubit


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
        color_id: int = None,
        vertices: list[tuple[int, int]] = None,
    ) -> None:
        super().__init__()

        self._vertices = [] if vertices is None else vertices
        self._type = PathType.LONG_RANGE_CNOT if type is None else type
        self._color_id = color_id

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
        return str(
            [(compute_equivalent_letter(v[0]), v[1] + 1) for v in self._vertices]
        ).replace("'", "")

    # Iterator
    def __iter__(self):
        return VertexIterator(self)

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
        e1 = {(first[i], first[i + 1]) for i in range(len(first) - 1)}
        e2 = {(second[i], second[i + 1]) for i in range(len(second) - 1)}

        return not e1.intersection(e2)

    # Check if the terminals of the path are disjoint from another path
    def is_terminal_disjoint(self, other: Path) -> bool:
        first = self._vertices
        second = other._vertices

        return (
            first[0] != second[0]
            and first[-1] != second[-1]
            and first[0] != second[-1]
            and first[-1] != second[0]
        )

    # Getter for the type of the path
    def get_type(self) -> PathType:
        return self._type

    # Returns new path without the current terminals, i.e. the interior of the path
    def interior(self) -> Path:
        return Path(self._type, self._color_id, self._vertices[1:-1])

    # Getter for the color of the path
    def get_color_id(self) -> int:
        return self._color_id

    # Setter for the color of the path
    def set_color_id(self, color_id: int) -> None:
        self._color_id = color_id


# Iterator over the vertices of a path
class VertexIterator:
    def __init__(self, path: Path) -> None:
        self._index = 0
        self._path = path

    def __iter__(self):
        return self

    def __next__(self) -> tuple[int, int]:
        if self._index < len(self._path):
            result = self._path[self._index]
            self._index += 1
            return result

        raise StopIteration


# Class for paths that are denoted using only key vertices on that path
# described in the paper
class KeyPath(Path):
    def __init__(self, start: tuple[int, int], stop: tuple[int, int]) -> None:
        super().__init__()

        assert is_data_qubit(start)
        assert is_data_qubit(stop)

        start_r, start_c = start
        stop_r, stop_c = stop

        self._vertices = [  # They are not consistent in the paper, the use this path scheme in proofs but then use different ones in the graphics
            (start_r, start_c),
            (start_r - 1, start_c),
            (start_r - 1, stop_c - 1),
            (stop_r, stop_c - 1),
            (stop_r, stop_c),
        ]

    # Extend the KeyPath to a normal Path i.e. fill in the missing vertices
    def extend_to_path(self) -> Path:
        path = Path(self._type, self._color_id)

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
