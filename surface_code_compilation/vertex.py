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

    # Length of the neighbor list
    def __len__(self) -> int:
        return len(self._neighbors)

    # Iterator
    def __iter__(self):
        return NeighborsIterator(self)

    # Append a neighbor to the vertex
    def append_neighbor(self, vertex: tuple[int, int]) -> None:
        self._neighbors.append(vertex)

    # Remove a neighbor from the vertex
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
    def __init__(self, idx: tuple[int, int], grid_dims: tuple[int, int]) -> None:
        super().__init__()

        self.append_neighbor((idx[0] - 1, idx[1]))

        if idx[0] + 1 < grid_dims[0]:
            self.append_neighbor((idx[0] + 1, idx[1]))


# Class representing the stopping vertex of path, has to be a data qubit
class Stop(Vertex):
    def __init__(self, idx: tuple[int, int], grid_dims: tuple[int, int]) -> None:
        super().__init__()

        self.append_neighbor((idx[0], idx[1] - 1))

        if idx[1] + 1 < grid_dims[1]:
            self.append_neighbor((idx[0], idx[1] + 1))


# Class representing a vertex in the middle of a path, must be an ancilla qubit
# i.e. no data qubit
class Ancilla(Vertex):
    def __init__(
        self,
        idx: tuple[int, int],
        grid_dims: tuple[int, int],
    ) -> None:
        super().__init__()

        self._idx = idx
        self._grid_dims = grid_dims
        self._restore_neighbors()

    def _restore_neighbors(self) -> None:
        self._neighbors = []

        # Initialize neighbors while checking for border cases
        if self._idx[1] % 2 == 0:
            if self._idx[0] > 0:
                self.append_neighbor((self._idx[0] - 1, self._idx[1]))

            if self._idx[0] + 1 < self._grid_dims[0]:
                self.append_neighbor((self._idx[0] + 1, self._idx[1]))

        if self._idx[0] % 2 == 0:
            if self._idx[1] > 0:
                self.append_neighbor((self._idx[0], self._idx[1] - 1))

            if self._idx[1] + 1 < self._grid_dims[1]:
                self.append_neighbor((self._idx[0], self._idx[1] + 1))
