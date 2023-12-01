use <polychannel.scad>

$fn=30;
small_number = 1e-6;

function cs(size, position, ang=[0, [0,0,1]]) = cube_shape(size, position, ang);

function channel_segment_spec(x=0.0, y=0.0, z=0.0) = [x, y, z];

function nearest_px(value, px=0.0076) = round(value / px) * px;
function position_nearest_px(position, px=0.0076) = [
    nearest_px(position[0], px), 
    nearest_px(position[1], px), 
    position[2]
];
function _element_wise_multiplication(a, b) = [a[0] * b[0], a[1] * b[1], a[2] * b[2]];
function _mult(a, b) = _element_wise_multiplication(a, b);
function _mult_nearest_px(a, b, px=0.076) = position_nearest_px( _mult(a, b), px);
// Recursively sum elements of a list such as [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
// which is [9, 12, 15].
function _sumlist(list, c = 0) = 
    c < len(list) - 1 ? 
        list[c] + _sumlist(list, c + 1) 
        :
        list[c];
// A valid set of relative intermediate points must sum to [1, 1, 1]
function check_relative_intermediate_points(pnts, tolerance=small_number) =
    let (diff = _sumlist(pnts) - [1, 1, 1])
    let (xdiff = abs(diff[0]))
    let (ydiff = abs(diff[1]))
    let (zdiff = abs(diff[2]))
    (xdiff < tolerance) && (ydiff < tolerance) && (zdiff < tolerance);

module connect_points(
    pA,                         // Starting point
    pB,                         // Ending point
    segment_specs,              // Specification of fractional distances in x,y,z for each segment to connect pA to pB
    snap_to_nearest_pixel=true, // Make sure x,y are in integer units of pixels
    px=0.0076,                  // Default pixel size in mm
    clr="cornflowerblue"        // Default channel color
) {
    // echo(_sumlist(segment_specs));
    // echo(check_relative_intermediate_points(segment_specs));
    assert(
        check_relative_intermediate_points(segment_specs), 
        "Relative intermediate points must sum to [1,1,1]"
    );
    delta_p = pB - pA;
    params = [
        for (i=[0:1:len(segment_specs)]) i==0 ?
            cs(chan_unit_size, pA)
            :
            snap_to_nearest_pixel ?
                cs(chan_unit_size, _mult_nearest_px(segment_specs[i-1], delta_p, px=px))
                :
                cs(chan_unit_size, _mult(segment_specs[i-1], delta_p))
            
    ];
    // echo(params);
    color(clr) polychannel(params);
}

// Example

chan_width = 1.0;
chan_height = 0.5;
chan_unit_size = [chan_width, chan_width, chan_height];
temp_px = 0.2;

pA = [3, 2, 1];
pB = [10, 6, 4];

_r = 0.5;
color("red") translate(pA) sphere(r=_r);
color("green") translate(pB) sphere(r=_r);

relative_intermediate_points = [
    channel_segment_spec(x=0.25),
    channel_segment_spec(z=-0.25),
    channel_segment_spec(y=0.43),
    channel_segment_spec(z=1.25),
    channel_segment_spec(y=0.57),
    channel_segment_spec(x=0.75),
];

// Print info to double check that everything is working correctly
echo();
echo(_sumlist(relative_intermediate_points));
echo(check_relative_intermediate_points(relative_intermediate_points));
echo(check_relative_intermediate_points(relative_intermediate_points));
echo();
echo();
echo(nearest_px(1.27, 0.2));
echo(position_nearest_px([0.83, 1.97, 2.51], 0.2));
temp_delta_p = pB - pA;
echo(temp_delta_p);
for (css=relative_intermediate_points) {
    echo(css, _mult(css, temp_delta_p), _mult_nearest_px(css, temp_delta_p, px=temp_px));
}

connect_points(pA, pB, relative_intermediate_points);
translate([0, -5, 0]) {
    color("red") translate(pA) sphere(r=_r);
    color("green") translate(pB) sphere(r=_r);
    connect_points(
        pA, 
        pB, 
        relative_intermediate_points, 
        snap_to_nearest_pixel=false,
        clr="IndianRed"
    );
}
