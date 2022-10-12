use <../polychannel.scad>


function _calc_arc_rot_i(angle1, delta_angle, n, i, rot_axis) = [
    angle1 + i*delta_angle/n, 
    rot_axis
];
function _calc_arc_xy_rot_deltaang_i(angle1, delta_angle, n, i) = 
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
function arc_xy(shape, size, radius, angle1, delta_angle, n) = 
    abs_to_rel_positions(_arc_xy_abs_position_deltaang(shape, size, radius, angle1, delta_angle, n));


eps=0.01;
text_rotate = [0,0,0];

n_segs90 = 12;
radius = 1.5;
width = 1.5;
height = 1;
size_for_arc_xy = [width, eps, height];

module row_of_arc_xy(start_ang_delta, delta_ang, n_samps, x_offset, y_offset, z_offset, clr="lightblue") {
    delta_ang1 = 75; 
    for (i=[0:1:n_samps-1]) {
        start_ang = i * start_ang_delta;
        location = [i * x_offset, y_offset, z_offset];
        // echo(i, start_ang, delta_ang, location);
        translate(location)
        polychannel(
            [
                each arc_xy("cube", size_for_arc_xy, radius, start_ang, delta_ang, n_segs90)
            ],
            clr=clr
        );
        color(clr) 
            translate(location + [0,4,0]) 
                rotate(text_rotate) 
                    scale(0.1) 
                        text(str(start_ang, ",", delta_ang),halign="center",valign="center");

    }
}

// Overall labels
color("black") translate([30,14,0]) rotate(text_rotate) scale(0.19) text("xy Arcs", halign="center", valign="center");
color("black") translate([16,10,0]) rotate(text_rotate) scale(0.16) text("Starting angle, delta angle");
color("black") translate([3,6.6,0]) rotate(text_rotate) scale(0.13) text("Positive starting angle");
color("black") translate([38,6.6,0]) rotate(text_rotate) scale(0.13) text("Negative starting angle");
color("black") translate([-22,1,0]) rotate(text_rotate) scale(0.13) text("delta angle = +75deg");
color("black") translate([-22,-9,0]) rotate(text_rotate) scale(0.13) text("delta angle = -75deg");
color("black") translate([-22,-19,0]) rotate(text_rotate) scale(0.13) text("delta angle = +165deg");
color("black") translate([-22,-29,0]) rotate(text_rotate) scale(0.13) text("delta angle = -165deg");

// Positive starting angles
row_of_arc_xy(90, 75, 5, 6, 0, 0, clr="lightblue");
row_of_arc_xy(90, -75, 5, 6, -10, 0, clr="blue");
row_of_arc_xy(90, 165, 5, 6, -20, 0, clr="lightgreen");
row_of_arc_xy(90, -165, 5, 6, -30, 0, clr="green");
// Negative starting angles
translate([35, 0, 0]) row_of_arc_xy(-90, 75, 5, 6, 0, 0, clr="lightblue");
translate([35, 0, 0]) row_of_arc_xy(-90, -75, 5, 6, -10, 0, clr="blue");
translate([35, 0, 0]) row_of_arc_xy(-90, 165, 5, 6, -20, 0, clr="lightgreen");
translate([35, 0, 0]) row_of_arc_xy(-90, -165, 5, 6, -30, 0, clr="green");
