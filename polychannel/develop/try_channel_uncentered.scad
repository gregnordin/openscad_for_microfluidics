use <../polychannel.scad>

$fn = 100;
eps = 0.01;

no_rotation = no_rot();
n_segs90 = 10;
params_verbose = [
    ["sphr", [eps, 4, 4], [0, 0, 0], no_rotation],
    ["sphr", [eps, 4, 4], [7, 0, 0], no_rotation],
    ["sphr", [eps, 3, 3], [0, 0, 0], no_rotation],
    ["cube", [eps, 1, 1], [3, 0, 0], no_rotation],
    ["cube", [eps, 1*sqrt(2), 1], [3, 0, 0], rot_z(45)],
    ["cube", [eps, 1, 1], [0, 2, 0], rot_z(90)],
    ["cube", [3, 1, 3], [0, 3, 0], no_rotation],
    ["cube", [1, eps, 1], [0, 2, 0], no_rotation],
    ["sphr", [eps, 1*sqrt(2), 1], [0, 2, 0], rot_z(45)],
    ["sphr", [eps, 2, 2], [5, 0, 0], no_rotation],
    ["sphr", [2, 2, 2], [2, 0, 0], no_rotation],
    ["sphr", [2, 2, 2], [0, -4, 4], no_rotation],
    ["cube", [1, eps, 2], [0, -3, 0], no_rotation],
    each arc_xy("cube", [1, eps, 2], radius=3, angle1=0, delta_angle=-90, n=n_segs90),
    ["cube", [1, 1, 2], [-2, 0, 0], no_rotation],
    each arc_xz("cube", [2, 1, eps], radius=3, angle1=-90, delta_angle=-180, n=2*n_segs90),
    each arc_xy("cube", [1, eps, 2], radius=1, angle1=-90, delta_angle=90, n=n_segs90),
    ["cube", [1, eps, 1], [0, 5, 0], no_rotation],
    each arc_xy("cube", [1, eps, 1], radius=1, angle1=0, delta_angle=90, n=n_segs90),
    [.5, [2, 3, 4], [-5, 0, 0], no_rotation],
    ["cube", [eps, 1, 1], [-10, 0, 0], no_rotation],
];

show_only_shapes = false;

// polychannel(params_verbose, clr="Salmon", show_only_shapes=show_only_shapes);

// translate([0, 25, 0]) polychannel(params_verbose, center=false, show_only_shapes=show_only_shapes);

// translate([0, -25, 0]) 
//     polychannel(
//         rel_to_abs_positions(params_verbose), 
//         relative_positions=false, 
//         center=true, 
//         clr="lightgreen", 
//         show_only_shapes=show_only_shapes
//     );

// translate([0, -50, 0]) 
//     polychannel(
//         rel_to_abs_positions(params_verbose), 
//         relative_positions=false, 
//         center=false, 
//         clr="yellowgreen", 
//         show_only_shapes=show_only_shapes
//     );

params_uncentered = [
    ["sphr", [eps, 4, 4], [0, 0, 0], no_rotation],
    ["sphr", [eps, 4, 4], [7, 0, 0], no_rotation],
    ["sphr", [eps, 3, 3], [0, 0, 0], no_rotation],
    ["cube", [eps, 1, 1], [3, -0.5, -0.5], no_rotation],
    ["cube", [eps, 1*sqrt(2), 1], [3, 0, 0], rot_z(45)],
    ["cube", [eps, 1, 1], [0, 2, 0], rot_z(90)],
    ["cube", [eps, 3, 3], [0, 3, 0], rot_z(90)],
    ["cube", [1, eps, 1], [0, 2, 0], no_rotation],
    // ["sphr", [eps, 1*sqrt(2), 1], [0, 2, 0], rot_z(45)],
    // ["sphr", [eps, 2, 2], [5, 0, 0], no_rotation],
    // ["sphr", [2, 2, 2], [2, 0, 0], no_rotation],
    // ["sphr", [2, 2, 2], [0, -4, 4], no_rotation],
    // ["cube", [1, eps, 2], [0, -3, 0], no_rotation],
    // each arc_xy("cube", [1, eps, 2], radius=3, angle1=0, delta_angle=-90, n=n_segs90),
    // ["cube", [1, 1, 2], [-2, 0, 0], no_rotation],
    // each arc_xz("cube", [2, 1, eps], radius=3, angle1=-90, delta_angle=-180, n=2*n_segs90),
    // each arc_xy("cube", [1, eps, 2], radius=1, angle1=-90, delta_angle=90, n=n_segs90),
    // ["cube", [1, eps, 1], [0, 5, 0], no_rotation],
    // each arc_xy("cube", [1, eps, 1], radius=1, angle1=0, delta_angle=90, n=n_segs90),
    // [.5, [2, 3, 4], [-5, 0, 0], no_rotation],
    // ["cube", [eps, 1, 1], [-10, 0, 0], no_rotation],
];

chan_w = 1;
chan_h = 0.5;
params_cubes_uncentered = [
    ["cube", [eps, chan_w, chan_h], [0, 0, 0], no_rotation],
    ["cube", [eps, chan_w*sqrt(2), chan_h], [3, 0, 0], rot_z(45)],
    ["cube", [eps, chan_w, chan_h], [0, 2, 0], rot_z(90)],
    ["cube", [eps, 3, 3], [0, 3, 0], rot_z(90)],
    ["cube", [eps, chan_w, chan_h], [0, 2, 0], rot_z(90)],
    ["cube", [chan_w, eps, chan_h], [0, 2, 0], no_rotation],
    // ["sphr", [eps, 1*sqrt(2), 1], [0, 2, 0], rot_z(45)],
];

relative_positions = false;
center = false;

abs_params_cubes_uncentered = rel_to_abs_positions(params_cubes_uncentered);
echo();
for (i=[0:len(params_cubes_uncentered)-1])
    echo(i, params_cubes_uncentered[i]);
echo();
for (i=[0:len(abs_params_cubes_uncentered)-1])
    echo(i, abs_params_cubes_uncentered[i]);
echo();

// translate([0, -75, 0]) 
    polychannel(
        rel_to_abs_positions(params_cubes_uncentered),
        relative_positions=relative_positions, 
        center=center, 
        clr="Aquamarine", 
        show_only_shapes=true,
    );

translate([0, 10, 0]) 
    polychannel(
        rel_to_abs_positions(params_cubes_uncentered),
        relative_positions=relative_positions, 
        center=center, 
        clr="lightgreen", 
        show_only_shapes=false,
    );
