use <polychannel.scad>

$fn=30;
small_number = 1e-6;

function cs(size, position, ang=[0, [0,0,1]]) = cube_shape(size, position, ang);

function channel_segment_spec(x=0.0, y=0.0, z=0.0) = [x, y, z];
function _element_wise_multiplication(a, b) = [a[0] * b[0], a[1] * b[1], a[2] * b[2]];
function _mult(a, b) = _element_wise_multiplication(a, b);
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

module connect_points(pA, pB, segment_specs, clr="cornflowerblue") {
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
            cs(chan_unit_size, _mult(segment_specs[i-1], delta_p))
            
    ];
    // echo(params);
    color(clr) polychannel(params);
}

// Example

chan_width = 1.0;
chan_height = 0.5;
chan_unit_size = [chan_width, chan_width, chan_height];

pA = [3, 2, 1];
pB = [10, 6, 4];

_r = 0.5;
color("red") translate(pA) sphere(r=_r);
color("green") translate(pB) sphere(r=_r);

relative_intermediate_points = [
    channel_segment_spec(z=-0.3),
    channel_segment_spec(y=1),
    channel_segment_spec(z=1.3),
    channel_segment_spec(x=1),
];
echo();
echo(_sumlist(relative_intermediate_points));
echo(check_relative_intermediate_points(relative_intermediate_points));
echo();
connect_points(pA, pB, relative_intermediate_points);
echo();

