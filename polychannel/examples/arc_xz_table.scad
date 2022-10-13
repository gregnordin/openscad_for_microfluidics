use <../polychannel.scad>
include <../unicode.scad>

eps=0.01;
text_rotate = [90,0,0];

n_segs90 = 12;
radius = 1.5;
width = 1.5;
height = 1;
size_for_arc_xz = [height, width, eps];

module row_of_arc_xz(start_ang_delta, delta_ang, n_samps, x_offset, y_offset, z_offset, clr="lightblue") {
    for (i=[0:1:n_samps-1]) {
        start_ang = i * start_ang_delta;
        location = [i * x_offset, y_offset, z_offset];
        // echo(i, start_ang, delta_ang, location);
        translate(location)
        polychannel(
            [
                each arc_xz("cube", size_for_arc_xz, radius, start_ang, delta_ang, n_segs90)
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
color("black") translate([30,0,12]) rotate(text_rotate) scale(0.19) 
    text(str("arc_xz(", theta, ", ", Delta, theta, ")"), halign="center", valign="center");
color("black") translate([3,0,6.6]) rotate(text_rotate) scale(0.13) text("Positive starting angle");
color("black") translate([38,0,6.6]) rotate(text_rotate) scale(0.13) text("Negative starting angle");
color("black") translate([-22,0,1]) rotate(text_rotate) scale(0.13) text("delta angle = +75deg");
color("black") translate([-22,0,-9]) rotate(text_rotate) scale(0.13) text("delta angle = -75deg");
color("black") translate([-22,0,-19]) rotate(text_rotate) scale(0.13) text("delta angle = +165deg");
color("black") translate([-22,0,-29]) rotate(text_rotate) scale(0.13) text("delta angle = -165deg");

// Positive starting angles
row_of_arc_xz(90, 75, 5, 6, 0, 0, clr="lightblue");
row_of_arc_xz(90, -75, 5, 6, 0, -10, clr="blue");
row_of_arc_xz(90, 165, 5, 6, 0, -20, clr="lightgreen");
row_of_arc_xz(90, -165, 5, 6, 0, -30, clr="green");
// Negative starting angles
translate([35, 0, 0]) row_of_arc_xz(-90, 75, 5, 6, 0, 0, clr="lightblue");
translate([35, 0, 0]) row_of_arc_xz(-90, -75, 5, 6, 0, -10, clr="blue");
translate([35, 0, 0]) row_of_arc_xz(-90, 165, 5, 6, 0, -20, clr="lightgreen");
translate([35, 0, 0]) row_of_arc_xz(-90, -165, 5, 6, 0, -30, clr="green");
