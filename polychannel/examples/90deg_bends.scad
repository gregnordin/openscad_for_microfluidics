use <../polychannel.scad>

// Note: all examples use relative coordinates to specify shape positions.

eps = 0.01;

// Simple rectangular straight channels and 90deg bends.
width_90bends = 1.5;
height_90bends = 1;
size_90bends = [width_90bends, width_90bends, height_90bends];
params_90bends = [
    ["cube", size_90bends, [0, 0, 0], no_rot()],
    ["cube", size_90bends, [8, 0, 0], no_rot()],
    ["cube", size_90bends, [0, 7, 0], no_rot()],
    ["cube", size_90bends, [0, 0, 3], no_rot()],
    ["cube", size_90bends, [0, -4, 0], no_rot()],
    ["cube", size_90bends, [-3, 0, 0], no_rot()],
    ["cube", size_90bends, [0, 0, -2], no_rot()],
    ["cube", size_90bends, [-5, 0, 0], no_rot()],
];
translate([0, 45, 0]) {
    polychannel(params_90bends, clr="Salmon", show_only_shapes=true);
    translate([0, 10, 0]) polychannel(params_90bends);
};

// Similar but use thin shapes.
params_90bends_thin = [
    ["cube", [eps, width_90bends, height_90bends], [0, 0, 0], no_rot()],
    ["cube", [eps, width_90bends*sqrt(2), height_90bends], [8, 0, 0], rot_z(45)],
    ["cube", [width_90bends, eps, height_90bends*sqrt(2)], [0, 7, 0], rot_x(45)],
    ["cube", [width_90bends, eps, height_90bends*sqrt(2)], [0, 0, 3], rot_x(-45)],
    ["cube", [eps, width_90bends*sqrt(2), height_90bends], [0, -4, 0], rot_z(45)],
    ["cube", [eps, width_90bends, height_90bends*sqrt(2)], [-3, 0, 0], rot_y(-45)],
    ["cube", [eps, width_90bends, height_90bends*sqrt(2)], [0, 0, -2], rot_y(-45)],
    ["cube", [eps, width_90bends, height_90bends], [-5, 0, 0], no_rot()],
];
translate([0, 20, 0]) {
    polychannel(params_90bends_thin, clr="Salmon", show_only_shapes=true);
    translate([0, 10, 0]) polychannel(params_90bends_thin);
};

// Similar but use circular arcs.
n_segs90 = 12;
radius90 = 1.5;
params_90bends_arcs = [
    ["cube", [eps, width_90bends, height_90bends], [0, 0, 0], no_rot()],
    ["cube", [eps, width_90bends, height_90bends], [6.5, 0, 0], no_rot()],
    each arc_xy("cube", [width_90bends, eps, height_90bends], radius90, -90, 90, n_segs90),
    ["cube", [width_90bends, eps, height_90bends], [0, 4, 0], no_rot()],
    each arc_yz("cube", [width_90bends, height_90bends, eps], radius90, -90, 180, 2*n_segs90),
    ["cube", [width_90bends, eps, height_90bends], [0, -1.5, 0], no_rot()],
    each arc_xy("cube", [width_90bends, eps, height_90bends], radius90, 0, -90, n_segs90),
    ["cube", [eps, width_90bends, height_90bends], [-0.5, 0, 0], no_rot()],
    each arc_xz("cube", [height_90bends, width_90bends, eps], radius90/1.5, 90, 90, n_segs90),
    each arc_xz("cube", [height_90bends, width_90bends, eps], radius90/1.5, 0, -90, n_segs90),
    ["cube", [eps, width_90bends, height_90bends], [-4, 0, 0], no_rot()],
];
translate([0, 0, 0]) {
    polychannel(params_90bends_arcs, clr="Salmon", show_only_shapes=true);
    translate([0, 10, 0]) polychannel(params_90bends_arcs);
};

// Similar but use set_first_position() to create relative offset for start of circular arcs.
params_90bends_arcs2 = [
    ["cube", [eps, width_90bends, height_90bends], [0, 0, 0], no_rot()],
    each set_first_position(
        arc_xy("cube", [width_90bends, eps, height_90bends], radius90, -90, 90, n_segs90), 
        pos=[6.5, 0, 0]),
    each set_first_position(
        arc_yz("cube", [width_90bends, height_90bends, eps], radius90, -90, 180, 2*n_segs90),
        pos=[0, 4, 0]),
    each set_first_position(
        arc_xy("cube", [width_90bends, eps, height_90bends], radius90, 0, -90, n_segs90),
        pos=[0, -1.5, 0]),
    each set_first_position(
        arc_xz("cube", [height_90bends, width_90bends, eps], radius90/1.5, 90, 90, n_segs90),
        pos=[-0.5, 0, 0]),
    each arc_xz("cube", [height_90bends, width_90bends, eps], radius90/1.5, 0, -90, n_segs90),
    ["cube", [eps, width_90bends, height_90bends], [-4, 0, 0], no_rot()],
];
translate([20, 0, 0]) {
    polychannel(params_90bends_arcs2, clr="Red", show_only_shapes=true);
    translate([0, 10, 0]) polychannel(params_90bends_arcs2, clr="Turquoise");
};