import matplotlib.pyplot as plt
from matplotlib.table import Table
import matplotlib.colors as mcolors

from path import Path
from helpers import is_data_qubit


class Visualizer:
    def __init__(
        self,
        grid_dims: tuple[int, int],
        scheduling: list[list[Path]],
    ) -> None:
        self._grid_dims: tuple[int, int] = grid_dims
        self._scheduling: list[list[Path]] = scheduling

    # https://stackoverflow.com/a/10195347
    def visualize(self):
        _, ax = plt.subplots(1, len(self._scheduling))

        if len(self._scheduling) == 1:
            ax = [ax]

        for a, epoch in enumerate(self._scheduling):
            ax[a].set_title(f"Epoch {a + 1}", y=1.08)
            ax[a].set_axis_off()
            tb = Table(ax[a])

            colors = list(mcolors.TABLEAU_COLORS)

            nrows, ncols = self._grid_dims
            size = 1.0 / ncols if ncols >= nrows else 1.0 / nrows

            # Add cells
            for i in range(nrows):
                for j in range(ncols):
                    if i % 2 == 0 and j % 2 == 0:
                        color = "grey"
                    elif i % 2 == 1 and j % 2 == 1:
                        color = "black"
                    else:
                        color = "white"

                    tb.add_cell(i, j, size, size, facecolor=color)

            for c, path in enumerate(epoch):
                for i, qubit in enumerate(path):
                    if i == 0 and is_data_qubit(qubit):
                        text = f"{i}\nCONTROL"
                    elif i == len(path) - 1 and is_data_qubit(qubit):
                        text = f"{i}\nTARGET"
                    else:
                        text = str(i)

                    tb.add_cell(
                        *qubit,
                        size,
                        size,
                        facecolor=colors[c],
                        text=text,
                        loc="center",
                    )

            # Row Labels
            for i in range(nrows):
                # times = i // 26 + 1 # TODO use characters like in the paper
                # char = chr((i % 26) + 65)

                tb.add_cell(
                    i,
                    -1,
                    size,
                    size,
                    # text=char * times,
                    text=i,
                    loc="right",
                    edgecolor="none",
                    facecolor="none",
                )

            # Column Labels
            for j in range(ncols):
                tb.add_cell(
                    -1,
                    j,
                    size,
                    size / 2,
                    # text=j + 1,
                    text=j,
                    loc="center",
                    edgecolor="none",
                    facecolor="none",
                )
            ax[a].add_table(tb)
            ax[a].set_aspect("equal")

        plt.show()
