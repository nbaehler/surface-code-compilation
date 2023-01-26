# Convert a 2D index into a 1D index
def flatten(r: int, c: int, grid_dims: tuple[int, int]) -> int:
    return r * grid_dims[1] + c


# Convert a 1D index into a 2D index
def unflatten(i: int, grid_dims: tuple[int, int]) -> tuple[int, int]:
    return i // grid_dims[1], i % grid_dims[1]


# Check if a qubit is a data qubit in the sense of the paper
def is_data_qubit(i: tuple[int, int]) -> bool:
    return i[0] % 2 == 1 and i[1] % 2 == 1


def change_coordinate(row: int) -> str:
    times = row // 26 + 1
    char = chr((row % 26) + 65)
    return char * times
