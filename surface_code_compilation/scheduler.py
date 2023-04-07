from abc import ABC, abstractmethod

import numpy as np
from epoch import (
    Epoch,
    epochs_edge_disjoint,
    get_length_of_scheduling,
    phases_vertex_disjoint,
)
from operator_graph import OperatorGraph
from path import KeyPath, Path

# class Scheduling: # TODO needed?
#     def __init__(self, epochs: list[Epoch]) -> None:
#         super().__init__()

#         self._epochs = epochs

#     def __len__(self) -> int:
#         return np.sum([len(epoch) for epoch in self._epochs])


# Class modelling a scheduler for compilation
class Scheduler(ABC):
    def __init__(
        self,
        grid_dims: tuple[int, int],
        cnots: list[tuple[tuple[int, int], tuple[int, int]]],
    ) -> None:
        super().__init__()
        self._grid_dims: tuple[int, int] = grid_dims
        self._cnots: list[tuple[tuple[int, int], tuple[int, int]]] = cnots

    @abstractmethod
    def schedule(self) -> list[Epoch]:
        pass


# Helper function that assigns IDs to the paths in the given scheduling
def assign_path_ids(scheduling: list[Epoch]) -> None:
    path_id = 0

    for epoch in scheduling:
        for path in epoch._paths:
            path.set_path_id(path_id)
            path_id += 1


# Scheduler that does not perform any optimization and simply schedules the
# operations sequentially
class Sequential(Scheduler):
    def schedule(self):
        scheduling = [
            Epoch([KeyPath(cnot[0], cnot[1]).extend_to_path()]) for cnot in self._cnots
        ]

        assign_path_ids(scheduling)

        return scheduling


# Scheduler that is based on the paper
class EDPC(Scheduler):
    def schedule(self):
        # First approach, using the paper's novel algorithm, compute the
        # operator EDP sets
        q1 = self.__compute_operator_edp_sets()

        assert epochs_edge_disjoint(q1)

        # Assign IDs to the paths
        assign_path_ids(q1)

        # Split operator EDP sets into operator VDP sets
        for operator_edp_set in q1:
            operator_edp_set.edp_subroutine()

        assert phases_vertex_disjoint(q1)

        # Second approach, using the greedy algorithm, build operator graph
        operator_graph = OperatorGraph(self._grid_dims, self._cnots)

        q2: list[Epoch] = []
        while self._cnots:
            # Compute as many minimal length shortest path between terminal
            # pairs as possible that do not intersect
            covered_terminal_pairs, p_star = self.__greedy_vdp(
                operator_graph, self._cnots
            )

            # Make progress
            assert covered_terminal_pairs != []

            # Remove the covered terminal pairs
            for pair in covered_terminal_pairs:
                self._cnots.remove(pair)

            q2.append(Epoch(p_star))

        assert phases_vertex_disjoint(q2)

        # Assign IDs to the paths
        assign_path_ids(q2)

        l1 = get_length_of_scheduling(q1)
        l2 = get_length_of_scheduling(q2)

        # Pick the shorter scheduling of both approaches
        if l1 <= l2:
            print(f"Using paper approach: len(q1)={l1} vs len(q2)={l2}")
            scheduling = q1
        else:
            print(f"Using greedy approach: len(q1)={l1} vs len(q2)={l2}")
            scheduling = q2

        # Contains at least one empty epoch
        if not scheduling:
            scheduling = [Epoch([])]

        return scheduling

    # Compute edge disjoint operator sets
    def __compute_operator_edp_sets(  # TODO Paper suggest to use graph coloring instead, this is just brute force
        self,
    ) -> list[Epoch]:
        paths = [KeyPath(ctrl, tgt).extend_to_path() for ctrl, tgt in self._cnots]

        # Construct operator EDP sets
        operator_edp_sets: list[Epoch] = []
        for current_path in paths:
            added = False

            # Check if the current path is edge disjoint with all of the paths
            # of any of existing operator EDP sets and that no terminals are shared
            for operator_edp_set in operator_edp_sets:
                conflict = any(
                    not current_path.is_terminal_disjoint(other_path)
                    or not current_path.is_edge_disjoint(other_path)
                    for other_path in operator_edp_set._paths
                )

                # Is edge disjoint with all of the paths of the current operator
                # set and does not share any terminals
                if not conflict:
                    operator_edp_set.append_path(current_path)
                    added = True
                    break

            # If the current path couldn't be added to any of the existing
            # operator sets, append a new operator set at the end
            if not added:
                operator_edp_sets.append(Epoch([current_path]))

        return operator_edp_sets

    # Greedily compute the set of shortest paths connecting the given terminal
    # pairs that are vertex disjoint
    def __greedy_vdp(
        self,
        operator_graph: OperatorGraph,
        terminal_pairs: list[tuple[tuple[int, int], tuple[int, int]]],
    ) -> tuple[list[tuple[tuple[int, int], tuple[int, int]]], list[Path]]:
        A: list[Path] = []
        # Remove duplicates, terminals can't be present twice (not just as pairs)
        unique_terminal_pairs = []
        used_terminals = []  # TODO get rid of this redundant list
        for pair in terminal_pairs:
            if pair[0] not in used_terminals and pair[1] not in used_terminals:
                unique_terminal_pairs.append(pair)
                used_terminals.extend(pair)

        covered_terminal_pairs = []
        operator_graph._restore_initial_state()

        # While not all terminal pairs have been connected
        while unique_terminal_pairs != []:
            # Compute the shortest path between any terminal pair possible in
            # the operator graph
            (
                shortest_path_terminal_pair,
                p_star,
            ) = self.__compute_minimal_length_shortest_path_between_terminal_pairs(
                operator_graph, unique_terminal_pairs
            )

            # If no such path exists, return the current set of paths
            if p_star is None:
                return covered_terminal_pairs, A

            # Remove the ancilla qubits from the operator graph used in the
            # current path
            operator_graph._remove_ancillas_in_path(p_star)
            A.append(p_star)
            covered_terminal_pairs.append(shortest_path_terminal_pair)

            # Remove the covered terminal pair from the list of terminal pairs
            unique_terminal_pairs.remove(shortest_path_terminal_pair)

        return covered_terminal_pairs, A

    # Compute the shortest path between any terminal pair possible in the
    # operator graph
    def __compute_minimal_length_shortest_path_between_terminal_pairs(  # TODO the paper suggests to use Dijkstra's algorithm instead of BFS
        self,
        operator_graph: OperatorGraph,
        terminal_pairs: list[tuple[tuple[int, int], tuple[int, int]]],
    ) -> tuple[tuple[tuple[int, int], tuple[int, int]], Path]:
        shortest_path_terminal_pair = None
        shortest_path = None
        length = np.inf

        # Go over all terminal pairs
        for terminal_pair in terminal_pairs:
            # Add the current terminal pair to the operator graph
            operator_graph._add_terminal_pair(terminal_pair)

            # Compute the shortest path between the two terminal vertices
            path = operator_graph._shortest_path(terminal_pair[0], terminal_pair[1])

            # Remove the current terminal pair from the operator graph again
            operator_graph._remove_terminal_pair(terminal_pair)

            # Check the current path is shorter than the shortest path found so far
            if path is not None and len(path) < length:
                length = len(path)
                shortest_path = path
                shortest_path_terminal_pair = terminal_pair

        return shortest_path_terminal_pair, shortest_path
