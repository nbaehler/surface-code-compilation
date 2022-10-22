import numpy as np


class Graph:
    def __init__(
        self, grid_dims: tuple[int, int], cnots: list[tuple[int, int]]
    ) -> None:
        self._terminals = np.full(grid_dims, -1)

        for i, cnot in enumerate(cnots):
            pass
