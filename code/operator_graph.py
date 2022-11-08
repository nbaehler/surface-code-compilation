import numpy as np

from helpers import unflatten
from path import PaperKeyPath, CompletePath
from vertex import Ancilla, Start, Stop, Vertex


class OperatorGraph:
    def __init__(
        self,
        grid_dims: tuple[int, int],
        mapping: dict[int, int],
        cnots: list[tuple[int, int]],
    ) -> None:
        self._grid_dims: tuple[int, int] = grid_dims
        self._cnots: list[tuple[tuple[int, int], tuple[int, int]]] = []

        for cnot in cnots:
            ctrl = unflatten(mapping[cnot[0]], self._grid_dims)
            tgt = unflatten(mapping[cnot[1]], self._grid_dims)

            self._cnots.append((ctrl, tgt))

    def _build_initial_operator_graph(self) -> None:
        self._operator_graph = np.empty(self._grid_dims, dtype=Vertex)

        for i in range(self._grid_dims[0]):
            for j in range(self._grid_dims[1]):
                if i % 2 == 0 or j % 2 == 0:
                    self._operator_graph[i, j] = Ancilla((i, j), self._grid_dims)
                else:
                    self._operator_graph[i, j] = Vertex()

    def _add_terminal_pair(
        self, terminal: tuple[tuple[int, int], tuple[int, int]]
    ) -> None:
        (ctrl, tgt) = terminal
        self._operator_graph[ctrl] = Start(ctrl)
        self._operator_graph[(ctrl[0] - 1, ctrl[1])].add_neighbor(ctrl)
        self._operator_graph[(ctrl[0] + 1, ctrl[1])].add_neighbor(ctrl)

        self._operator_graph[tgt] = Stop(tgt)
        self._operator_graph[(tgt[0], tgt[1] - 1)].add_neighbor(tgt)
        self._operator_graph[(tgt[0], tgt[1] + 1)].add_neighbor(tgt)

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

    def _remove_ancillas_in_path(self, path: CompletePath) -> None:
        for i in range(1, len(path) - 2):
            vertex_position = path[i]
            next_vertex_position = path[i + 1]

            self._operator_graph[vertex_position].remove_neighbor(next_vertex_position)
            self._operator_graph[next_vertex_position].remove_neighbor(vertex_position)

    def _shortest_path(  # TODO BFS algorithm, paper uses Dijkstra's algorithm
        self, start: tuple[int, int], stop: tuple[int, int]
    ) -> CompletePath:
        distances = np.full(self._grid_dims, -1, dtype=int)
        queue = [start]
        distances[start] = 0

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

        return None

    def __compute_path_from_distances(
        self, start: tuple[int, int], stop: tuple[int, int], distances: np.ndarray
    ) -> CompletePath:
        path = CompletePath()
        current = stop

        while current != start:
            path.add_vertex(current)

            for i in self._operator_graph[current]:
                if distances[i] == distances[current] - 1:

                    assert current != i
                    current = i
                    break

        path.add_vertex(start)
        path.reverse()
        return path

    def _build_operator_edp_sets(
        self,
    ) -> list[list[PaperKeyPath]]:
        paths = [PaperKeyPath(ctrl, tgt) for ctrl, tgt in self._cnots]

        operator_edp_sets = [[]]
        for new_path in paths:  # TODO use graph coloring instead, this is inefficient
            added = False
            for operator_edp_set in operator_edp_sets:
                share_edges = any(
                    new_path.is_edge_disjoint(set_path) for set_path in operator_edp_set
                )

                if not share_edges:
                    operator_edp_set.append(new_path)
                    added = True
                    break

            if not added:
                operator_edp_sets.append([new_path])

        return operator_edp_sets
