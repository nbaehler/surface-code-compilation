def flatten(r, c, grid_dims):
    return r * grid_dims[1] + c


def unflatten(idx, grid_dims):
    return idx // grid_dims[1], idx % grid_dims[1]
