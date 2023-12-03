use <../polychannel.scad>
use <../serpentine3D.scad>
use <../channel_connect_points.scad>


$fn = 100;

// Serpentine parameters
nx = 5;
l = 15;
gap_x = 1;
chan_width = 1;
chan_height = 0.8;
nz = 5;
gap_z = 2.2;
serp_params = [nx, l, gap_x, chan_width, chan_height, nz, gap_z];

serpentine3D(serp_params);

echo("Serpentine start position:", serp_start_position(serp_params));
echo("Serpentine end position:", serp_end_position(serp_params));

chan_unit_size = [chan_width, chan_width, chan_height];

// Connect inlet point p0 to serpentine start position
p0 = [-10, -10, 0];
in_chan_segments = [
    relative_connection_segment(relative_x=0.33),
    relative_connection_segment(relative_y=0.5),
    relative_connection_segment(relative_x=0.67),
    relative_connection_segment(relative_y=0.5),
    relative_connection_segment(relative_z=1),
];
connect_points(
    p0, 
    serp_start_position(serp_params), 
    in_chan_segments, 
    chan_unit_size, 
    clr="RosyBrown"
);

// Make less verbose
function rcs(x=0,y=0,z=0) = relative_connection_segment(x,y,z);

// Connect outlet point p1 to serpentine end position
p1 = [-10, -13, 0];
out_chan_segments = [
    rcs(y=-0.15),
    rcs(z=0.5),
    rcs(x=0.67),
    rcs(y=1.15),
    rcs(z=0.5),
    rcs(x=0.33),
];
connect_points( serp_end_position(serp_params), p1, out_chan_segments, chan_unit_size, clr="lightgreen");

_r = 0.6*chan_unit_size[0];
color("red") translate(p0) sphere(r=_r);
color("green") translate(p1) sphere(r=_r);

