from locale import currency
import numpy as np

from helpers import unflatten


class OperatorGraph:
    def __init__(
        self,
        grid_dims: tuple[int, int],
    ) -> None:
        self._grid_dims = grid_dims
        self._graph = np.full(grid_dims, -1)

    def build_paths(
        self, mapping: dict[int, int], cnots: list[tuple[int, int]]
    ) -> list[list[tuple[int, int]]]:
        paths = []

        for cnot in cnots:
            ctrl_r, ctrl_c = unflatten(mapping[cnot[0]], self._grid_dims)
            tgt_r, tgt_c = unflatten(mapping[cnot[1]], self._grid_dims)

            print(f"ctrl: ({ctrl_r}, {ctrl_c})")
            print(f"tgt: ({tgt_r}, {tgt_c})")

            current_r = ctrl_r
            current_c = ctrl_c
            path = [(current_r, current_c)]

            if current_r > tgt_r:
                current_r -= 1
            else:
                current_r += 1

            path.append((current_r, current_c))
            
            if current_c > tgt_c:
                current_c += current_c - (tgt_c - 1)
            else:
                current_c += (tgt_c + 1) - current_c

            current_r += current_r - tgt_r if current_r > tgt_r else tgt_r - current_r

            path.append((current_r, current_c))

       

            path.append((current_r, current_c))

            if current_c > tgt_c:
                current_c -= 1
            else:
                current_c += 1

            path.append((current_r, current_c))

            print(path)

            assert current_r == tgt_r and current_c == tgt_c

            paths.append(path)

        return paths
