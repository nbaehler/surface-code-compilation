def flatten(r, c, grid_dims):
    return r * grid_dims[1] + c


def unflatten(i, grid_dims):
    return i // grid_dims[1], i % grid_dims[1]
