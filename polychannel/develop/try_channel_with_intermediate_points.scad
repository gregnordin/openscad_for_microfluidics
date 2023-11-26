use <../polychannel.scad>

$fn=30;

function cs(size, position, ang=[0, [0,0,1]]) = cube_shape(size, position, ang);

chan_width = 1.0;
chan_height = 0.5;
chan_unit_size = [chan_width, chan_width, chan_height];

function channel_segment_spec(x=0.0, y=0.0, z=0.0) = [x, y, z];
function element_wise_mult(a, b) = [a[0] * b[0], a[1] * b[1], a[2] * b[2]];
function ewm(a, b) = element_wise_mult(a, b);
// Recursively sum elements of a list such as [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
// which is [9, 12, 15].
function sumlist(list, c = 0) = 
    c < len(list) - 1 ? 
        list[c] + sumlist(list, c + 1) 
        :
        list[c];
function check_relative_intermediate_points(pnts) =
    sumlist(pnts) == [1, 1, 1];

    

echo();
echo(sumlist([[0, 1, 2], [3, 4, 5], [6, 7, 8]]));
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
polychannel(params_1);

echo();
echo(element_wise_mult(channel_segment_spec(x=1), [1, 1, 1]));
echo(ewm(channel_segment_spec(x=1), [1, 1, 1]));

delta_p = pB - pA;
params_2 = [
    cs(chan_unit_size, pA),
    cs(chan_unit_size, ewm(channel_segment_spec(x=1), delta_p)),
    cs(chan_unit_size, ewm(channel_segment_spec(y=1), delta_p)),
    cs(chan_unit_size, ewm(channel_segment_spec(z=1), delta_p)),
];
polychannel(params_2);

relative_intermediate_points = [
    channel_segment_spec(z=-0.3),
    channel_segment_spec(y=1),
    channel_segment_spec(z=1.3),
    channel_segment_spec(x=1),
];
echo();
echo(sumlist(relative_intermediate_points));
echo(check_relative_intermediate_points(relative_intermediate_points));
echo();
params_3 = [
    cs(chan_unit_size, pA),
    cs(chan_unit_size, ewm(channel_segment_spec(z=-0.3), delta_p)),
    cs(chan_unit_size, ewm(channel_segment_spec(y=1), delta_p)),
    cs(chan_unit_size, ewm(channel_segment_spec(z=1.3), delta_p)),
    cs(chan_unit_size, ewm(channel_segment_spec(x=1), delta_p)),
];
// color("cornflowerblue") polychannel(params_3);

module connect_points(pA, pB, segment_specs, clr="cornflowerblue") {
    echo(sumlist(segment_specs));
    echo(check_relative_intermediate_points(segment_specs));
    delta_p = pB - pA;
    params = [
        for (i=[0:1:len(segment_specs)]) i==0 ?
            cs(chan_unit_size, pA)
            :
            cs(chan_unit_size, ewm(segment_specs[i-1], delta_p))
            
    ];
    echo(params);
    color(clr) polychannel(params);
}

connect_points(pA, pB, relative_intermediate_points);
