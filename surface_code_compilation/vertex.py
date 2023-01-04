# Class representing nodes in the operator graph
class Vertex:
    def __init__(self) -> None:
        self._neighbors: list[tuple[int, int]] = []

    # Getter for the neighbors of the vertex
    def __getitem__(self, i: int) -> tuple[int, int]:
        if i < 0:
            i += len(self)

        if i < 0 or i >= len(self):
            raise IndexError(
                f"Index {i} out of range for vertex's neighbor list of length {len(self)}"
            )

        return self._neighbors[i]

    def __len__(self) -> int:
        return len(self._neighbors)

    def __iter__(self):
        return NeighborsIterator(self)

    def append_neighbor(self, vertex: tuple[int, int]) -> None:
        self._neighbors.append(vertex)

    def remove_neighbor(self, vertex: tuple[int, int]) -> None:
        self._neighbors.remove(vertex)


# Iterator over the neighbors of a vertex
class NeighborsIterator:
    def __init__(self, vertex):
        self._vertex = vertex
        self._index = 0

    def __next__(self):
        if self._index < len(self._vertex):
            result = self._vertex[self._index]
            self._index += 1
            return result

        raise StopIteration


# Class representing the starting vertex of path, has to be a data qubit
class Start(Vertex):
    def __init__(self, i: tuple[int, int]) -> None:
        super().__init__()

        # Vertical neighbors only
        self.append_neighbor((i[0] - 1, i[1]))
        self.append_neighbor((i[0] + 1, i[1]))


# Class representing the stopping vertex of path, has to be a data qubit
class Stop(Vertex):
    def __init__(self, i: tuple[int, int]) -> None:
        super().__init__()

        # Horizontal neighbors only
        self.append_neighbor((i[0], i[1] - 1))
        self.append_neighbor((i[0], i[1] + 1))


# Class representing a vertex in the middle of a path, must be an ancilla qubit
# aka no data qubit
class Ancilla(Vertex):
    def __init__(self, i: tuple[int, int], grid_dims: tuple[int, int]) -> None:
        super().__init__()

        # Initialize neighbors while checking for border cases
        if i[1] % 2 == 0:
            if i[0] > 0:
                self.append_neighbor((i[0] - 1, i[1]))

            if i[0] < grid_dims[0] - 1:
                self.append_neighbor((i[0] + 1, i[1]))
        if i[0] % 2 == 0:
            if i[1] > 0:
                self.append_neighbor((i[0], i[1] - 1))

            if i[1] < grid_dims[1] - 1:
                self.append_neighbor((i[0], i[1] + 1))