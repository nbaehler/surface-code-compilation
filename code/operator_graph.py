import numpy as np

from helpers import unflatten
from path import KeyPath, NormalPath
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

    def _build_operator_graph(self) -> None:
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

    def _remove_ancillas_in_path(self, path: NormalPath) -> None:
        for i in range(1, len(path) - 2):
            vertex_position = path[i]
            next_vertex_position = path[i + 1]

            self._operator_graph[vertex_position].remove_neighbor(next_vertex_position)
            self._operator_graph[next_vertex_position].remove_neighbor(vertex_position)

    def _shortest_path(  # TODO BFS algorithm, paper uses Dijkstra's algorithm
        self, start: tuple[int, int], stop: tuple[int, int]
    ) -> NormalPath:
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
    ) -> NormalPath:
        path = NormalPath()
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
    ) -> tuple[list[list[KeyPath]], list[set[tuple[int, int]]]]:
        list_operator_edp_sets = []
        operator_edp_set = []
        list_crossing_vertices = []
        crossing_vertices = set()
        self.__reset_vertex_used()

        for (ctrl, tgt) in self._cnots:
            if self.__vertex_is_used(ctrl) or self.__vertex_is_used(
                tgt
            ):  # End of paths can't overlap
                list_operator_edp_sets.append(operator_edp_set)
                operator_edp_set = []
                list_crossing_vertices.append(crossing_vertices)
                crossing_vertices = set()
                self.__reset_vertex_used()

            path = KeyPath(ctrl, tgt)
            operator_edp_set.append(path)
            crossing_vertices.update(self.__update_used_and_get_crossing_vertices(path))

        if operator_edp_set != [[]]:
            list_operator_edp_sets.append(operator_edp_set)
            list_crossing_vertices.append(crossing_vertices)

        return list_operator_edp_sets, list_crossing_vertices

    def __vertex_is_used(self, i: tuple[int, int]) -> bool:
        return self._used_vertices[i[0], i[1]]

    def __reset_vertex_used(self) -> None:
        self._used_vertices = np.zeros(self._grid_dims, dtype=bool)

    def __update_used_and_get_crossing_vertices(
        self, path: KeyPath
    ) -> list[tuple[int, int]]:
        self._used_vertices[path[0]] = True

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
                    if self.__vertex_is_used((r, start[1])):
                        temp.extend((r, start[1]))
                    else:
                        self._used_vertices[r, start[1]] = True

            else:
                if start[1] < stop[1]:
                    f = start[1] + 1
                    t = stop[1] + 1
                else:
                    f = stop[1]
                    t = start[1]

                for c in range(f, t):
                    if self.__vertex_is_used((start[0], c)):
                        temp.extend((start[0], c))
                    else:
                        self._used_vertices[start[0], c] = True

            crossing_vertices.extend(temp)

        return crossing_vertices
