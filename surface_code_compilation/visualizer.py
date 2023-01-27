import matplotlib.colors as mcolors
import matplotlib.pyplot as plt
from helpers import change_coordinate, is_data_qubit
from matplotlib.table import Table
from path import Path


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

            for path in epoch:
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
                        facecolor=colors[path.get_color_id() % len(colors)],
                        text=text,
                        loc="center",
                    )

            # Row Labels
            for i in range(nrows):
                tb.add_cell(
                    i,
                    -1,
                    size,
                    size,
                    text=change_coordinate(i),
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
                    text=j + 1,
                    loc="center",
                    edgecolor="none",
                    facecolor="none",
                )
            ax[a].add_table(tb)
            ax[a].set_aspect("equal")

        plt.show()
