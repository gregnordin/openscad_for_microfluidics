use <../polychannel.scad>

$fn=30;
small_number = 1e-6;

function cs(size, position, ang=[0, [0,0,1]]) = cube_shape(size, position, ang);

chan_width = 1.0;
chan_height = 0.5;
chan_unit_size = [chan_width, chan_width, chan_height];

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
    

echo();
echo(_sumlist([[0, 1, 2], [3, 4, 5], [6, 7, 8]]));
echo();

pA = [3, 2, 1];
pB = [10, 6, 4];

_r = 0.5;
color("red") translate(pA) sphere(r=_r);
color("green") translate(pB) sphere(r=_r);

params_1 = [
    cs(chan_unit_size, pA),      // This gives pA as the starting position
    cs(chan_unit_size, pB - pA)  // Must specify relative position
];
color("orange") polychannel(params_1);

echo();
echo(_element_wise_multiplication(channel_segment_spec(x=1), [1, 1, 1]));
echo(_mult(channel_segment_spec(x=1), [1, 1, 1]));

delta_p = pB - pA;
params_2 = [
    cs(chan_unit_size, pA),
    cs(chan_unit_size, _mult(channel_segment_spec(x=1), delta_p)),
    cs(chan_unit_size, _mult(channel_segment_spec(y=1), delta_p)),
    cs(chan_unit_size, _mult(channel_segment_spec(z=1), delta_p)),
];
polychannel(params_2);

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


function nearest_px(value, px=0.0076) = round(value / px) * px;
px = 1.0;
for (i=[0:20]) {
    echo(i, i*px/5, nearest_px(i*px/5, px));
}


// // These relative itermediate points do not sum to [1,1,1]
// bad_intermediate_points = [
//     channel_segment_spec(z=-0.4),
//     channel_segment_spec(y=1),
//     channel_segment_spec(z=1.3),
//     channel_segment_spec(x=1),
// ];
// echo();
// echo("bad_intermediate_points", bad_intermediate_points);
// echo("_sumlist", _sumlist(bad_intermediate_points));
// echo(check_relative_intermediate_points(bad_intermediate_points));
// echo(-1, abs(-1));
// echo(small_number);
// echo();
// connect_points(pA, pB, bad_intermediate_points);

