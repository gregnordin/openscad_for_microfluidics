use <../polychannel.scad>

// Shortcuts
function cs(size, position, ang=[0, [0,0,1]]) = cube_shape(size, position, ang);
function ss(size, position, ang=[0, [0,0,1]]) = sphere_shape(size, position, ang);

cube_size = [0.01, 2, 0.5];
sphere_size = [2, 2, 3];

polychannel(
    [
        cs(cube_size, [0, 0, 0]),
        ss(sphere_size, [5, 0, 0]),
        cs(cube_size, [0, 5, 0], [90, [0, 0, 1]]),
    ]
);
