use <polychannel.scad>

$fn=30;
small_number = 1e-6;
default_px = 0.0076;
default_layer = 0.01;

// Shorthand function definition for convenience
function cs(size, position, ang=[0, [0,0,1]]) = cube_shape(size, position, ang);

// Fundamental data structure for relative connection strategy
function relative_connection_segment(
    relative_x=0.0, 
    relative_y=0.0, 
    relative_z=0.0) = [relative_x, relative_y, relative_z];

// Snap position to nearest (pixel, pixel, layer) position
function nearest_px(value, px=default_px) = round(value / px) * px;
function nearest_layer(value, layer=default_layer) = nearest_px(value, layer);
function position_nearest_px_layer(position, px=default_px, layer=default_layer) = [
    nearest_px(position[0], px), 
    nearest_px(position[1], px), 
    nearest_layer(position[2], layer),
];
function _element_wise_multiplication(a, b) = [a[0] * b[0], a[1] * b[1], a[2] * b[2]];
function _mult(a, b) = _element_wise_multiplication(a, b);
function _mult_nearest_px_layer(a, b, px=default_px, layer=default_layer) = 
    position_nearest_px_layer( _mult(a, b), px, layer);

// Recursively sum elements of a list such as [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
// which is [9, 12, 15]
function _sumlist(list, c = 0) = 
    c < len(list) - 1 ? 
        list[c] + _sumlist(list, c + 1) 
        :
        list[c];
// A valid set of relative intermediate points must sum to [1, 1, 1]
function check_relative_connection_segments(pnts, tolerance=small_number) =
    let (diff = _sumlist(pnts) - [1, 1, 1])
    let (xdiff = abs(diff[0]))
    let (ydiff = abs(diff[1]))
    let (zdiff = abs(diff[2]))
    (xdiff < tolerance) && (ydiff < tolerance) && (zdiff < tolerance);
// Positions snapped to nearest pixel and layer
function _snapped_relative_points(positions, px=default_px, layer=default_layer) = 
    [
        for (position in positions) 
            position_nearest_px_layer(position, px, layer)
    ];

// Use list of `relative_connection_segment`s to create channel
// connecting points pA and pB. The channel size is determined by the
// rectangular volume, `chan_unit_size`. The polychannel hull() 
// operation connects these rectangular volumes positioned at the 
// specified relative intermediate positions, which in turn creates
// a channel connection between points pA and pB. 
module connect_points(
    pA,                         // Starting point
    pB,                         // Ending point
    segment_specs,              // Specification of fractional distances in x,y,z for each segment to connect pA to pB
    chan_unit_size,             // Array of form [size_x, size_y, size_z] for rectangular channels
    snap_to_nearest_pixel=false, // Make sure x,y are in integer units of pixels and z in integer units of layers
    px=default_px,              // Default pixel size in mm
    layer=default_layer,        // Default layer size in mm
    clr="cornflowerblue"        // Default channel color
) {
    // echo(_sumlist(segment_specs));
    // echo(check_relative_connection_segments(segment_specs));
    assert(
        check_relative_connection_segments(segment_specs), 
        "Relative channel segments must sum to [1,1,1]"
    );
    delta_p = pB - pA;
    params = [
        for (i=[0:1:len(segment_specs)]) i==0 ?
            cs(chan_unit_size, pA)   // First position is pA
            :                        // All other positions are relative to pA
            snap_to_nearest_pixel ?  
                cs(
                    chan_unit_size, 
                    _mult_nearest_px_layer(segment_specs[i-1], delta_p, px=px, layer=layer)
                )
                :
                cs(chan_unit_size, _mult(segment_specs[i-1], delta_p))
    ];
    echo(params);
    color(clr) polychannel(params);
}

// Example

temp_px = 1;
temp_layer = 1;
temp_chan_width = 2 * temp_px;
temp_chan_height = 2 * temp_layer;
chan_unit_size = [temp_chan_width, temp_chan_width, temp_chan_height];

pA = [0, 0, 0];
pB = [20*temp_px, 10*temp_px, 10*temp_px];

_r = 0.65*chan_unit_size[0];
color("red") translate(pA) sphere(r=_r);
color("green") translate(pB) sphere(r=_r);

relative_channel_segments = [
    relative_connection_segment(relative_x=0.26),
    relative_connection_segment(relative_z=0.57),
    relative_connection_segment(relative_x=0.74),

    relative_connection_segment(relative_y=1),
    relative_connection_segment(relative_z=0.43),
    // relative_connection_segment(relative_x=0.33),
    // relative_connection_segment(relative_z=-0.25),
    // relative_connection_segment(relative_y=0.43),
    // relative_connection_segment(relative_z=1.55),
    // relative_connection_segment(relative_y=0.57),
    // relative_connection_segment(relative_x=0.33),
    // relative_connection_segment(relative_z=-1.51),
    // relative_connection_segment(relative_x=0.34),
    // relative_connection_segment(relative_z=1.21),
];

// Print info to double check that everything is working correctly
// Quick test with fixed values
echo();
echo(nearest_px(1.27, 0.2));
echo(position_nearest_px_layer([0.83, 1.97, 2.63], px=0.2, layer=0.5));
echo();
echo();
// Quick check using example values
echo(_sumlist(relative_channel_segments));
echo(check_relative_connection_segments(relative_channel_segments));
echo();
temp_delta_p = pB - pA;
echo(temp_delta_p);
for (segment=relative_channel_segments) {
    echo(
        segment, 
        _mult(segment, temp_delta_p), 
        _mult_nearest_px_layer(segment, temp_delta_p, px=temp_px, layer=temp_layer)
    );
}

// Channel with snapping to pixels/layers
echo();
connect_points(pA, pB, relative_channel_segments, chan_unit_size, px=temp_px, layer=temp_layer);

// Channel without snapping to pixels/layers
echo();
translate([0, -chan_unit_size[1]-0.1, 0])
mirror([0, -1, 0]) {
    color("red") translate(pA) sphere(r=_r);
    color("green") translate(pB) sphere(r=_r);
    connect_points(
        pA, 
        pB, 
        relative_channel_segments,
        chan_unit_size,
        snap_to_nearest_pixel=true,
        px=temp_px, 
        layer=temp_layer,
        clr="IndianRed"
    );
}
echo();

relative_channel_segments2 = [
    relative_connection_segment(relative_x=0.33),
    relative_connection_segment(relative_z=-0.25),
    relative_connection_segment(relative_y=0.43),
    relative_connection_segment(relative_z=1.55),
    relative_connection_segment(relative_y=0.57),
    relative_connection_segment(relative_x=0.33),
    relative_connection_segment(relative_z=-1.51),
    relative_connection_segment(relative_x=0.54),
    relative_connection_segment(relative_y=-0.33),
    relative_connection_segment(relative_z=1.21),
    relative_connection_segment(relative_x=-0.2),
    relative_connection_segment(relative_y=0.33),
];
pA2 = [5, 20, 3];
pB2 = [23, 35, 15];
color("red") translate(pA2) sphere(r=_r);
color("green") translate(pB2) sphere(r=_r);
connect_points(
    pA2, 
    pB2, 
    relative_channel_segments2, 
    chan_unit_size, 
    // snap_to_nearest_pixel=false,
    px=temp_px, 
    layer=temp_layer,
    clr="RosyBrown"
);
echo(_sumlist(relative_channel_segments2));
echo(check_relative_connection_segments(relative_channel_segments2));
echo();
