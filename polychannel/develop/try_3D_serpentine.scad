// use <../polychannel.scad>
use <../serpentine.scad>
use <../serpentinecircularends.scad>

function is_even(x) = true ? x%2 == 0 : false;
function is_odd(x) = true ? x%2 == 1 : false;
// function serp_chan_end_position() = 2;

default_params = [

];

nx = 5;
l = 15;
gap_x = 1;
chan_width = 1;
chan_height = 0.8;

n_z = 5;
gap_z = 2.2;

module vertical_connector(w, h, gap_z) {
    l = gap_z + 2 * h;
    translate([0, 0, 0.5 * l]) cube([w, w, l], center=true);
}

echo();
for (i=[1:4]) {
    echo(i, i-1, i%2, is_even(i), is_odd(i));
}
for (j=[1:n_z]) {
    translate([0, 0, (j-1)*(gap_z + chan_height)])
        serpentine_channel_circ(n=nx, l=l, gap=gap_x, cross_section=[chan_width, chan_height], clr="cornflowerblue");
    if (j != n_z) {
        if (is_odd(j)){
            _position_odd = [(gap_x + chan_width) * (nx - 1), l * (nx % 2), (j-1) * (gap_z + chan_height) - 0.5*chan_height];
            translate(_position_odd) vertical_connector(chan_width, chan_height, gap_z);
        }
        else {
            _position_even = [0, 0, (j-1) * (gap_z + chan_height) - 0.5*chan_height];
            translate(_position_even) vertical_connector(chan_width, chan_height, gap_z);
        }
    }
}

end_1 = [(gap_x + chan_width) * (nx - 1), l * (nx % 2), 0];
echo(end_1);

translate([0, 0, -5]) 
    serpentine_channel(n=nx, l=l, gap=gap_x, size=[chan_width, chan_width, chan_height], clr="Salmon");
