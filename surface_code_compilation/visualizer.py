import matplotlib.pyplot as plt
from epoch import Epoch, get_length_of_scheduling, get_phases_of_scheduling
from helpers import compute_equivalent_letter, is_data_qubit
from matplotlib.table import Table


# Class for visualizing the scheduling
class Visualizer:
    def __init__(
        self,
        grid_dims: tuple[int, int],
        scheduling: list[Epoch],
    ) -> None:
        self._grid_dims: tuple[int, int] = grid_dims
        self._scheduling: list[Epoch] = scheduling

    def visualize(self):
        n_phases = get_length_of_scheduling(self._scheduling)

        _, axs = plt.subplots(1, n_phases, figsize=(10, 10 * n_phases))

        # Scheduling only contains one phase
        if n_phases == 1:
            axs = [axs]

        # Setup
        n_rows, n_cols = self._grid_dims
        size = 1.0 / n_cols if n_cols >= n_rows else 1.0 / n_rows

        phases = get_phases_of_scheduling(self._scheduling)

        for ax, phase in enumerate(phases):
            # Setup
            axs[ax].set_title(f"Phase {ax + 1}", y=1.08)
            axs[ax].set_axis_off()
            axs[ax].set_aspect("equal")

            table = Table(axs[ax])

            table.auto_set_font_size(False)
            table.set_fontsize(10)

            # Add the white/grey/black cells of the basic grid
            for i in range(n_rows):
                for j in range(n_cols):
                    if i % 2 == 0 and j % 2 == 0:
                        color = "lightgrey"
                    elif i % 2 == 1 and j % 2 == 1:
                        color = "black"
                    else:
                        color = "white"

                    table.add_cell(i, j, size, size, facecolor=color)

            # Overlay the paths onto the before created grid
            for path in phase:
                for i, qubit in enumerate(path):
                    # Label text for the qubits
                    if i == 0 and is_data_qubit(qubit):
                        text = f"{i}\nCONTROL"
                    elif i == len(path) - 1 and is_data_qubit(qubit):
                        text = f"{i}\nTARGET"
                    else:
                        text = str(i)

                    table.add_cell(
                        *qubit,
                        size,
                        size,
                        facecolor=f"C{path.get_path_id()}",
                        text=text,
                        loc="center",
                    )

            # Row Labels
            for i in range(n_rows):
                table.add_cell(
                    i,
                    -1,
                    size,
                    size,
                    text=compute_equivalent_letter(i),
                    loc="right",
                    edgecolor="none",
                    facecolor="none",
                )

            # Column Labels
            for j in range(n_cols):
                table.add_cell(
                    -1,
                    j,
                    size,
                    size / 2,
                    text=j + 1,
                    loc="center",
                    edgecolor="none",
                    facecolor="none",
                )

            axs[ax].add_table(table)

        plt.show()
