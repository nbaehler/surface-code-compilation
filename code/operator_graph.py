import numpy as np

from helpers import unflatten, is_data_qubit


class Path:
    def __init__(self, ctrl: tuple[int, int], tgt: tuple[int, int]) -> None:
        assert is_data_qubit(ctrl)
        assert is_data_qubit(tgt)

        ctrl_r, ctrl_c = ctrl
        tgt_r, tgt_c = tgt

        self._path = [
            (ctrl_r, ctrl_c),
            (ctrl_r - 1, ctrl_c),
            (ctrl_r - 1, tgt_c - 1),
            (tgt_r, tgt_c - 1),
            (tgt_r, tgt_c),
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

    def __getitem__(self, i: int) -> tuple[int, int]:
        return self._path[i]

    def __len__(self) -> int:
        return len(self._path)

    def contains(self, qubit: tuple[int, int]) -> bool:
        if qubit in [
            self._path[0],
            self._path[1],
            self._path[3],
            self._path[4],
        ]:  # First and last are impossible in practice
            return True

        if qubit[0] == self._path[1][0]:
            f = min(self._path[1][1], self._path[2][1])
            t = max(self._path[1][1], self._path[2][1])

            return qubit in [(qubit[0], j) for j in range(f, t + 1)]

        elif qubit[1] == self._path[2][1]:
            f = min(self._path[2][0], self._path[3][0])
            t = max(self._path[2][0], self._path[3][0])

            return qubit in [(j, qubit[1]) for j in range(f, t + 1)]

        return False


class OperatorGraph:
    def __init__(
        self,
        grid_dims: tuple[int, int],
    ) -> None:
        self._grid_dims = grid_dims
        self.__reset()

    def build_operator_edp_sets(
        self, mapping: dict[int, int], cnots: list[tuple[int, int]]
    ) -> tuple[list[list[Path]], list[list[list[tuple[int, int]]]]]:
        list_operator_edp_sets = []
        operator_edp_set = []
        list_crossing_vertices = []
        crossing_vertices = []

        for cnot in cnots:
            ctrl = unflatten(mapping[cnot[0]], self._grid_dims)
            tgt = unflatten(mapping[cnot[1]], self._grid_dims)

            if self.__is_used(ctrl) or self.__is_used(
                tgt
            ):  # End of paths can't overlap
                list_operator_edp_sets.append(operator_edp_set)
                operator_edp_set = []
                list_crossing_vertices.append(crossing_vertices)
                crossing_vertices = []
                self.__reset()

            path = Path(ctrl, tgt)
            operator_edp_set.append(path)
            crossing_vertices.append(self.__get_crossing_vertices_and_set_used(path))

        if operator_edp_set != [[]]:
            list_operator_edp_sets.append(operator_edp_set)
            list_crossing_vertices.append(crossing_vertices)

        return list_operator_edp_sets, list_crossing_vertices

    def __is_used(self, i: tuple[int, int]) -> bool:
        return self._grid[i[0], i[1]]

    def __reset(self) -> None:
        self._grid = np.zeros(self._grid_dims, dtype=bool)

    def __get_crossing_vertices_and_set_used(self, path: Path) -> list[tuple[int, int]]:
        self._grid[path[0]] = True

        crossing_vertices = []
        for i in range(len(path) - 1):
            start = path[i]
            stop = path[i + 1]

            temp = []

            if start[0] != stop[0]:
                if start[0] < stop[0]:
                    f = start[0] + 1
                    t = stop[0] + 1
                else:
                    f = stop[0]
                    t = start[0]

                for r in range(f, t):
                    if self.__is_used((r, start[1])):
                        temp.extend((r, start[1]))
                    else:
                        self._grid[r, start[1]] = True

            else:
                if start[1] < stop[1]:
                    f = start[1] + 1
                    t = stop[1] + 1
                else:
                    f = stop[1]
                    t = start[1]

                for c in range(f, t):
                    if self.__is_used((start[0], c)):
                        temp.extend((start[0], c))
                    else:
                        self._grid[start[0], c] = True

            crossing_vertices.extend(temp)

        return crossing_vertices
