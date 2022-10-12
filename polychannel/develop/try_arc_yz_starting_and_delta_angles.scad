use <../polychannel.scad>


function _calc_arc_rot_i(angle1, delta_angle, n, i, rot_axis) = [
    angle1 + i*delta_angle/n, 
    rot_axis
];
function _calc_arc_yz_rot_deltaang_i(angle1, delta_angle, n, i) = 
    _calc_arc_rot_i(angle1, delta_angle, n, i, [1, 0, 0]);
function _calc_arc_yz_pos_deltaang_i(radius, angle1, delta_angle, n, i) = [
    0,
    radius*cos(angle1 + i*delta_angle/n), 
    radius*sin(angle1 + i*delta_angle/n)
];
function _arc_yz_pos_rot_deltaang_oneline(shape, size, radius, angle1, delta_angle, n, i) = [
    shape, 
    size, 
    _calc_arc_yz_pos_deltaang_i(radius, angle1, delta_angle, n, i), 
    _calc_arc_yz_rot_deltaang_i(angle1, delta_angle, n, i)
];
function _arc_yz_abs_position_deltaang(shape, size, radius, angle1, delta_angle, n) = [
    for (i=[0:1:n]) _arc_yz_pos_rot_deltaang_oneline(shape, size, radius, angle1, delta_angle, n, i)
];
function arc_yz(shape, size, radius, angle1, delta_angle, n) = 
    abs_to_rel_positions(_arc_yz_abs_position_deltaang(shape, size, radius, angle1, delta_angle, n));


eps=0.01;
text_rotate = [90,0,90];

n_segs90 = 12;
radius = 1.5;
width = 1.5;
height = 1;
size_for_arc_yz = [width, height, eps];

module row_of_arc_yz(start_ang_delta, delta_ang, n_samps, x_offset, y_offset, z_offset, clr="lightblue") {
    for (i=[0:1:n_samps-1]) {
        start_ang = i * start_ang_delta;
        location = [x_offset, i * y_offset, z_offset];
        // echo(i, start_ang, delta_ang, location);
        translate(location)
        polychannel(
            [
                each arc_yz("cube", size_for_arc_yz, radius, start_ang, delta_ang, n_segs90)
            ],
            clr=clr
        );
        color(clr) 
            translate(location + [0,0,4]) 
                rotate(text_rotate) 
                    scale(0.1) 
                        text(str(start_ang, ",", delta_ang),halign="center",valign="center");

    }
}

// Overall labels
color("black") translate([0,30,14]) rotate(text_rotate) scale(0.19) text("yz Arcs", halign="center", valign="center");
color("black") translate([0,16,10]) rotate(text_rotate) scale(0.16) text("Starting angle, delta angle");
color("black") translate([0,3,6.6]) rotate(text_rotate) scale(0.13) text("Positive starting angle");
color("black") translate([0,38,6.6]) rotate(text_rotate) scale(0.13) text("Negative starting angle");
color("black") translate([0,-22,1]) rotate(text_rotate) scale(0.13) text("delta angle = +75deg");
color("black") translate([0,-22,-9]) rotate(text_rotate) scale(0.13) text("delta angle = -75deg");
color("black") translate([0,-22,-19]) rotate(text_rotate) scale(0.13) text("delta angle = +165deg");
color("black") translate([0,-22,-29]) rotate(text_rotate) scale(0.13) text("delta angle = -165deg");

// Positive starting angles
row_of_arc_yz(90, 75, 5, 0, 6, 0, clr="lightblue");
row_of_arc_yz(90, -75, 5, 0, 6, -10, clr="blue");
row_of_arc_yz(90, 165, 5, 0, 6, -20, clr="lightgreen");
row_of_arc_yz(90, -165, 5, 0, 6, -30, clr="green");
// Negative starting angles
translate([0, 35, 0]) row_of_arc_yz(-90, 75, 5, 0, 6, 0, clr="lightblue");
translate([0, 35, 0]) row_of_arc_yz(-90, -75, 5, 0, 6, -10, clr="blue");
translate([0, 35, 0]) row_of_arc_yz(-90, 165, 5, 0, 6, -20, clr="lightgreen");
translate([0, 35, 0]) row_of_arc_yz(-90, -165, 5, 0, 6, -30, clr="green");
