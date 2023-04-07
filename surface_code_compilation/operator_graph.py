import numpy as np
from helpers import compute_equivalent_letter, is_data_qubit
from matplotlib import pyplot as plt
from matplotlib.table import Table
from path import Path
from vertex import Ancilla, Start, Stop, Vertex


# Class that implements the graph structure used in the paper
class OperatorGraph:
    def __init__(
        self,
        grid_dims: tuple[int, int],
        cnots: list[tuple[tuple[int, int], tuple[int, int]]],
    ) -> None:
        self._grid_dims: tuple[int, int] = grid_dims
        self._cnots: list[tuple[tuple[int, int], tuple[int, int]]] = cnots

        # Set up the operator graph, initialize all ancilla vertices
        self._operator_graph = np.empty(self._grid_dims, dtype=Vertex)

        for i in range(self._grid_dims[0]):
            for j in range(self._grid_dims[1]):
                if is_data_qubit((i, j)):
                    self._operator_graph[i, j] = Vertex()
                else:  # Is it an ancilla vertex?
                    self._operator_graph[i, j] = Ancilla((i, j), self._grid_dims)

    # Restore the initial state of the operator graph
    def _restore_initial_state(self) -> None:
        for i in range(self._grid_dims[0]):
            for j in range(self._grid_dims[1]):
                if not is_data_qubit((i, j)):
                    self._operator_graph[i, j]._restore_neighbors()

    # Add a terminal pair to the operator graph
    def _add_terminal_pair(
        self, terminal: tuple[tuple[int, int], tuple[int, int]]
    ) -> None:
        (ctrl, tgt) = terminal
        self._operator_graph[ctrl] = Start(ctrl, self._grid_dims)
        self._operator_graph[(ctrl[0] - 1, ctrl[1])].append_neighbor(ctrl)
        if ctrl[0] + 1 < self._grid_dims[0]:
            self._operator_graph[(ctrl[0] + 1, ctrl[1])].append_neighbor(ctrl)

        self._operator_graph[tgt] = Stop(tgt, self._grid_dims)
        self._operator_graph[(tgt[0], tgt[1] - 1)].append_neighbor(tgt)
        if tgt[1] + 1 < self._grid_dims[1]:
            self._operator_graph[(tgt[0], tgt[1] + 1)].append_neighbor(tgt)

    # Remove a terminal pair from the operator graph
    def _remove_terminal_pair(
        self, terminal: tuple[tuple[int, int], tuple[int, int]]
    ) -> None:
        (ctrl, tgt) = terminal
        self._operator_graph[ctrl] = Vertex()
        self._operator_graph[(ctrl[0] - 1, ctrl[1])].remove_neighbor(ctrl)
        if ctrl[0] + 1 < self._grid_dims[0]:
            self._operator_graph[(ctrl[0] + 1, ctrl[1])].remove_neighbor(ctrl)

        self._operator_graph[tgt] = Vertex()
        self._operator_graph[(tgt[0], tgt[1] - 1)].remove_neighbor(tgt)
        if tgt[1] + 1 < self._grid_dims[1]:
            self._operator_graph[(tgt[0], tgt[1] + 1)].remove_neighbor(tgt)

    # Remove all ancilla vertices from the operator graph that are traversed
    # inside the given path
    def _remove_ancillas_in_path(self, path: Path) -> None:
        for i in range(1, len(path) - 1):
            current_position = path[i]

            neighbors = self._operator_graph[current_position]._neighbors.copy()

            for neighbor_position in neighbors:
                self._operator_graph[neighbor_position].remove_neighbor(
                    current_position
                )
                self._operator_graph[current_position].remove_neighbor(
                    neighbor_position
                )

    # Compute the the shortest path between start and stop vertices in the
    # operator graph
    def _shortest_path(  # BFS algorithm, paper uses Dijkstra's algorithm
        self, start: tuple[int, int], stop: tuple[int, int]
    ) -> Path:
        distances = np.full(self._grid_dims, -1, dtype=int)
        queue = [start]
        distances[start] = 0

        # BFS
        while queue:
            current = queue.pop(0)

            for i in self._operator_graph[current]:
                if distances[i] == -1:
                    queue.append(i)
                    distances[i] = distances[current] + 1
                else:
                    distances[i] = min(distances[i], distances[current] + 1)

                if i == stop:
                    return self.__compute_path_from_distances(start, stop, distances)

        # Those two vertices are not connected
        return None

    # Compute the shortest path between a terminal pairs using the distances map
    # computed using the the BFS algorithm
    def __compute_path_from_distances(
        self, start: tuple[int, int], stop: tuple[int, int], distances: np.ndarray
    ) -> Path:
        path = Path()
        current = stop

        # Trace back the path in reverse order following the shortest remaining
        # distance to the start vertex
        while current != start:
            path.append_vertex(current)

            for i in self._operator_graph[current]:
                if distances[i] == distances[current] - 1:
                    # Always make progress
                    assert current != i
                    current = i
                    break

        path.append_vertex(start)

        # Reverse the path
        path.reverse()
        return path

    def _plot_operator_graph(self) -> None:
        # Setup
        n_rows, n_cols = self._grid_dims
        size = 1.0 / n_cols if n_cols >= n_rows else 1.0 / n_rows

        _, ax = plt.subplots(1)

        ax.set_axis_off()
        ax.set_aspect("equal")
        table = Table(ax)

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

                text = len(self._operator_graph[i, j])

                table.add_cell(
                    i,
                    j,
                    size,
                    size,
                    facecolor=color,
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

        ax.add_table(table)

        plt.show()
