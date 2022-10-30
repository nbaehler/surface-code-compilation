def flatten(r: int, c: int, grid_dims: tuple[int, int]) -> int:
    return r * grid_dims[1] + c


def unflatten(i: int, grid_dims: tuple[int, int]) -> tuple[int, int]:
    return i // grid_dims[1], i % grid_dims[1]


def is_data_qubit(i: tuple[int, int]) -> bool:
    return i[0] % 2 == 1 and i[1] % 2 == 1
