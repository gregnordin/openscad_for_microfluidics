use <../polychannel.scad>

function cs(size, position, ang=[0, [0,0,1]]) = cube_shape(size, position, ang);
function ss(size, position, ang=[0, [0,0,1]]) = sphere_shape(size, position, ang);

eps = 0.01;
params_pos_relative = [
    ss([eps, 4, 4], [0, 0, 0]),
    ss([eps, 4, 4], [7, 0, 0]),
    ss([eps, 3, 3], [0, 0, 0]),  // Note relative position is zero; this line effectively just changes the size of the circle leaving it in the same place.
    cs([eps, 0.5, 0.5], [3, 0, 0]),
    cs([0.5, 0.5, 0.5], [5, 0, 0]),
    cs([0.5, 0.5, 0.5], [0, 4, 0]),
];
polychannel(params_pos_relative);
color("red") translate([0, 0, 5]) polychannel(params_pos_relative, show_only_shapes=true);

//Annotations
color("blue") translate([8,-4,0]) rotate([90,0,0]) scale(0.1) text("polychannel() output",halign="center",valign="center");
color("blue") translate([8,-4,5]) rotate([90,0,0]) scale(0.1) text("Shapes-only",halign="center",valign="center");

