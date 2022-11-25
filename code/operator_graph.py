import numpy as np

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
    def _build_initial_operator_graph(self) -> None:
        self._operator_graph = np.empty(self._grid_dims, dtype=Vertex)

        for i in range(self._grid_dims[0]):
            for j in range(self._grid_dims[1]):
                # Is it an ancilla vertex?
                if i % 2 == 0 or j % 2 == 0:
                    self._operator_graph[i, j] = Ancilla((i, j), self._grid_dims)
                else:
                    self._operator_graph[i, j] = Vertex()

    # Add a terminal pair to the operator graph
    def _add_terminal_pair(
        self, terminal: tuple[tuple[int, int], tuple[int, int]]
    ) -> None:
        (ctrl, tgt) = terminal
        self._operator_graph[ctrl] = Start(ctrl)
        self._operator_graph[(ctrl[0] - 1, ctrl[1])].append_neighbor(ctrl)
        self._operator_graph[(ctrl[0] + 1, ctrl[1])].append_neighbor(ctrl)

        self._operator_graph[tgt] = Stop(tgt)
        self._operator_graph[(tgt[0], tgt[1] - 1)].append_neighbor(tgt)
        self._operator_graph[(tgt[0], tgt[1] + 1)].append_neighbor(tgt)

    # Remove a terminal pair from the operator graph
    def _remove_terminal_pair(
        self, terminal: tuple[tuple[int, int], tuple[int, int]]
    ) -> None:
        (ctrl, tgt) = terminal
        self._operator_graph[ctrl] = Vertex()
        self._operator_graph[(ctrl[0] - 1, ctrl[1])].remove_neighbor(ctrl)
        self._operator_graph[(ctrl[0] + 1, ctrl[1])].remove_neighbor(ctrl)

        self._operator_graph[tgt] = Vertex()
        self._operator_graph[(tgt[0], tgt[1] - 1)].remove_neighbor(tgt)
        self._operator_graph[(tgt[0], tgt[1] + 1)].remove_neighbor(tgt)

    # Remove all ancilla vertices from the operator graph that are traversed
    # inside the given path
    def _remove_ancillas_in_path(self, path: Path) -> None:
        for i in range(1, len(path) - 2):
            vertex_position = path[i]
            next_vertex_position = path[i + 1]

            self._operator_graph[vertex_position].remove_neighbor(next_vertex_position)
            self._operator_graph[next_vertex_position].remove_neighbor(vertex_position)

    # Compute the the shortest path between start and stop vertices in the
    # operator graph
    def _shortest_path(  # TODO BFS algorithm, paper uses Dijkstra's algorithm
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
