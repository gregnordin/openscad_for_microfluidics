use <../polychannel.scad>

function _calc_arc_xy_pos_i(radius, angle1, angle2, n, i) = [
    radius*cos(angle1 + i*(angle2-angle1)/n), 
    radius*sin(angle1 + i*(angle2-angle1)/n),
    0
];
function _calc_arc_xy_rot_i(angle1, angle2, n, i) = [
    angle1 + i*(angle2-angle1)/n, 
    [0, 0, 1]
];
function _arc_xy_pos_rot_oneline(shape, size, radius, angle1, angle2, n, i) = [
    shape, size, _calc_arc_xy_pos_i(radius, angle1, angle2, n, i), _calc_arc_xy_rot_i(angle1, angle2, n, i)
];
function _arc_xy_abs_position(shape, size, radius, angle1, angle2, n) = [
    for (i=[0:1:n]) _arc_xy_pos_rot_oneline(shape, size, radius, angle1, angle2, n, i)
];
function arc_xy_rel_position(shape, size, radius, angle1, angle2, n) = 
    abs_to_rel_positions(_arc_xy_abs_position(shape, size, radius, angle1, angle2, n));



function _calc_arc_rot_i(angle1, delta_angle, n, i, rot_axis) = [
    angle1 + i*delta_angle/n, 
    rot_axis
];
function _calc_arc_xy_rot_deltaang_i(angle1, delta_angle, n, i, rot_axis) = 
    _calc_arc_rot_i(angle1, delta_angle, n, i, [0, 0, 1]);
function _calc_arc_xy_pos_deltaang_i(radius, angle1, delta_angle, n, i) = [
    radius*cos(angle1 + i*delta_angle/n), 
    radius*sin(angle1 + i*delta_angle/n),
    0
];
function _arc_xy_pos_rot_deltaang_oneline(shape, size, radius, angle1, delta_angle, n, i) = [
    shape, 
    size, 
    _calc_arc_xy_pos_deltaang_i(radius, angle1, delta_angle, n, i), 
    _calc_arc_xy_rot_deltaang_i(angle1, delta_angle, n, i)
];
function _arc_xy_abs_position_deltaang(shape, size, radius, angle1, delta_angle, n) = [
    for (i=[0:1:n]) _arc_xy_pos_rot_deltaang_oneline(shape, size, radius, angle1, delta_angle, n, i)
];
function arc_xy_rel_position2(shape, size, radius, angle1, delta_angle, n) = 
    abs_to_rel_positions(_arc_xy_abs_position_deltaang(shape, size, radius, angle1, delta_angle, n));


eps=0.01;

n_segs90 = 12;
radius = 1.5;
width = 1.5;
height = 1;
size_for_arc_xy = [width, eps, height];
// size_for_arc_xz = [height, width, eps];
// size_for_arc_yz = [width, height, eps];
// size_yz = [eps, width, height];

// params_channel_with_arcs = [
//     ["cube", size_yz, [0, 0, 0], no_rot()],
//     each set_first_position(arc_xy_rel_position2("cube", size_for_arc_xy, radius, -90, 90, n_segs90), pos=[10, 0, 0]),
//     // each set_first_position(arc_yz_rel_position2("cube", size_for_arc_yz, radius, -90, 180, 2*n_segs90), pos=[0, 4, 0]),
//     // each set_first_position(arc_xy_rel_position2("cube", size_for_arc_xy, radius, 0, -90, n_segs90), pos=[0, -1.5, 0]),
//     // each set_first_position(arc_xz_rel_position2("cube", size_for_arc_xz, radius/1.5, 90, 180, n_segs90), pos=[-0.5, 0, 0]),
//     // each arc_xz_rel_position2("cube", size_for_arc_xz, radius/1.5, 0, -90, n_segs90),
//     // ["cube", size_yz, [-7.5, 0, 0], no_rot()],
// ];
// params1 = [
//     each set_first_position(arc_xy_rel_position2("cube", size_for_arc_xy, radius, 0, 75, n_segs90), pos=[0, 0, 0])
// ];

// polychannel(params1, clr="Salmon", show_only_shapes=true);
// translate([0, 10, 0]) 
//     polychannel(params1);

// delta_ang1 = 75; 
// for (i=[0:1:4]) {
//     start_ang = 90*i;
//     location = [5*i, 0, 0];
//     echo(i, start_ang, delta_ang1, location);
//     translate(location)
//     polychannel(
//         [
//             each arc_xy_rel_position2("cube", size_for_arc_xy, radius, start_ang, delta_ang1, n_segs90)
//         ]
//     );
//     color("blue") 
//         translate(location + [0,4,0]) 
//             rotate([0,0,0]) 
//                 scale(0.1) 
//                     text(str(start_ang, ",", delta_ang1),halign="center",valign="center");

// }
// color("blue") translate([-1.5,6,0]) rotate([0,0,0]) scale(0.12) text("Starting angle, delta angle"); //,halign="center",valign="center");

module row_of_arcs(start_ang_delta, delta_ang, n_samps, x_offset, y_offset, z_offset, clr="lightblue") {
    delta_ang1 = 75; 
    for (i=[0:1:n_samps-1]) {
        start_ang = i * start_ang_delta;
        location = [i * x_offset, y_offset, z_offset];
        // echo(i, start_ang, delta_ang, location);
        translate(location)
        polychannel(
            [
                each arc_xy_rel_position2("cube", size_for_arc_xy, radius, start_ang, delta_ang, n_segs90)
            ],
            clr=clr
        );
        color(clr) 
            translate(location + [0,4,0]) 
                rotate([0,0,0]) 
                    scale(0.1) 
                        text(str(start_ang, ",", delta_ang),halign="center",valign="center");

    }
}

color("blue") translate([-1.5,6,0]) rotate([0,0,0]) scale(0.12) text("Starting angle, delta angle"); //,halign="center",valign="center");
row_of_arcs(90, 75, 5, 6, 0, 0, clr="lightblue");
row_of_arcs(90, -75, 5, 6, -10, 0, clr="blue");
row_of_arcs(90, 165, 5, 6, -20, 0, clr="lightgreen");
row_of_arcs(90, -165, 5, 6, -30, 0, clr="green");
translate([35, 0, 0]) row_of_arcs(-90, 75, 5, 6, 0, 0, clr="lightblue");
translate([35, 0, 0]) row_of_arcs(-90, -75, 5, 6, -10, 0, clr="blue");
translate([35, 0, 0]) row_of_arcs(-90, 165, 5, 6, -20, 0, clr="lightgreen");
translate([35, 0, 0]) row_of_arcs(-90, -165, 5, 6, -30, 0, clr="green");
