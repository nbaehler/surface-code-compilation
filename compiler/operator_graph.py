import numpy as np

from helpers import unflatten


class OperatorGraph:
    def __init__(
        self,
        grid_dims: tuple[int, int],
    ) -> None:
        self._grid_dims = grid_dims
        self.__reset()

    def build_operator_edp_sets(
        self, mapping: dict[int, int], cnots: list[tuple[int, int]]
    ) -> tuple[list[list[list[tuple[int, int]]]], list[list[list[tuple[int, int]]]]]:
        operator_edp_sets = []
        operator_edp_set = []
        overlaps = []
        overlap = []

        for cnot in cnots:
            ctrl = unflatten(mapping[cnot[0]], self._grid_dims)
            tgt = unflatten(mapping[cnot[1]], self._grid_dims)

            assert self.is_data_qubit(ctrl)
            assert self.is_data_qubit(tgt)

            if self.__is_used(ctrl) or self.__is_used(tgt):
                operator_edp_sets.append(operator_edp_set)
                operator_edp_set = []
                overlaps.append(overlap)
                overlap = []
                self.__reset()

            ctrl_r, ctrl_c = ctrl
            tgt_r, tgt_c = tgt

            self._grid[ctrl_r, ctrl_c] = 1
            self._grid[tgt_r, tgt_c] = 1

            current_r = ctrl_r
            current_c = ctrl_c
            path = [(current_r, current_c)]

            if current_r > tgt_r:
                current_r -= 1
            else:
                current_r += 1
            path.append((current_r, current_c))

            if current_c > tgt_c:
                current_c -= current_c - (tgt_c + 1)
            else:
                current_c += (tgt_c - 1) - current_c
            path.append((current_r, current_c))

            current_r -= current_r - tgt_r if current_r > tgt_r else tgt_r - current_r
            path.append((current_r, current_c))

            if current_c > tgt_c:
                current_c -= 1
            else:
                current_c += 1
            path.append((current_r, current_c))

            assert current_r == tgt_r and current_c == tgt_c

            operator_edp_set.append(path)

            temp = []
            for i in range(len(path) - 1):
                temp.extend(self.__overlap(path[i], path[i + 1]))

            overlap.append(temp)

        if len(operator_edp_set) != 0:
            operator_edp_sets.append(operator_edp_set)
            overlaps.append(overlap)

        return operator_edp_sets, overlaps

    def is_data_qubit(self, i: tuple[int, int]) -> bool:
        return i[0] % 2 == 1 and i[1] % 2 == 1

    def __is_used(self, i: tuple[int, int]) -> bool:
        return self._grid[i[0], i[1]] > 0

    def __reset(self) -> None:
        self._grid = np.zeros(self._grid_dims)

    def __overlap(
        self, start: tuple[int, int], stop: tuple[int, int]
    ) -> list[tuple[int, int]]:
        overlap = []

        if start[0] != stop[0]:
            if start[0] < stop[0]:
                f = start[0]
                t = stop[0] + 1
            else:
                f = stop[0]
                t = start[0] + 1

            overlap.extend(
                (r, start[1]) for r in range(f, t) if self.__is_used((r, start[1]))
            )

        else:
            if start[1] < stop[1]:
                f = start[1]
                t = stop[1] + 1
            else:
                f = stop[1]
                t = start[1] + 1

            overlap.extend(
                (start[0], c) for c in range(f, t) if self.__is_used((start[0], c))
            )

        return overlap
