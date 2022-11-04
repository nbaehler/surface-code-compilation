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


class NormalPath(Path):
    def __init__(self, vertices: list[tuple[int, int]] = None) -> None:
        super().__init__()

        self._vertices = [] if vertices is None else vertices

    def add_vertex(self, vertex: tuple[int, int]) -> None:
        self._vertices.append(vertex)

    def reverse(self) -> None:
        self._vertices.reverse()


class KeyPath(Path):
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

        # TODO might add complications but leads to shorter paths
        # current_r = ctrl_r
        # current_c = ctrl_c
        # path = [(current_r, current_c)]

        # if current_r > tgt_r:  # Start -> vertical
        #     current_r -= 1
        # else:
        #     current_r += 1
        # path.append((current_r, current_c))

        # if current_c > tgt_c:
        #     current_c -= current_c - (tgt_c + 1)
        # else:
        #     current_c += (tgt_c - 1) - current_c
        # path.append((current_r, current_c))

        # current_r -= current_r - tgt_r if current_r > tgt_r else tgt_r - current_r
        # path.append((current_r, current_c))

        # if current_c > tgt_c:  # End -> horizontal
        #     current_c -= 1
        # else:
        #     current_c += 1
        # path.append((current_r, current_c))

        # assert current_r == tgt_r and current_c == tgt_c

    def contains(self, vertex_position: tuple[int, int]) -> bool:
        if vertex_position in [
            self._vertices[0],
            self._vertices[1],
            self._vertices[3],
            self._vertices[4],
        ]:  # First and last are impossible in practice
            return True

        if vertex_position[0] == self._vertices[1][0]:
            f = min(self._vertices[1][1], self._vertices[2][1])
            t = max(self._vertices[1][1], self._vertices[2][1])

            return vertex_position in [(vertex_position[0], j) for j in range(f, t + 1)]

        elif vertex_position[1] == self._vertices[2][1]:
            f = min(self._vertices[2][0], self._vertices[3][0])
            t = max(self._vertices[2][0], self._vertices[3][0])

            return vertex_position in [(j, vertex_position[1]) for j in range(f, t + 1)]

        return False

    def to_normal_path(self) -> NormalPath:
        path = NormalPath()

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
