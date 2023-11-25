use <serpentine.scad>
use <serpentinecircularends.scad>


default_nx = 5;
default_l = 15;
default_gap_x = 1;
default_chan_width = 1;
default_chan_height = 0.8;
default_nz = 5;
default_gap_z = 2.2;

default_params = [
    default_nx,
    default_l,
    default_gap_x,
    default_chan_width,
    default_chan_height,
    default_nz,
    default_gap_z
];

function serp_nx(p=default_params) = p[0];
function serp_l(p=default_params) = p[1];
function serp_gap_x(p=default_params) = p[2];
function serp_chan_width(p=default_params) = p[3];
function serp_chan_height(p=default_params) = p[4];
function serp_nz(p=default_params) = p[5];
function serp_gap_z(p=default_params) = p[6];

function serp_is_even(x) = true ? x%2 == 0 : false;
function serp_is_odd(x) = true ? x%2 == 1 : false;


module _serp_vertical_connector(w, h, gap_z) {
    l = gap_z + 2 * h;
    translate([0, 0, 0.5 * l]) cube([w, w, l], center=true);
}

module serpentine3D(p=default_params, clr="cornflowerblue", clr_vert="blue") {
    for (j=[1:serp_nz(p)]) {
        translate([0, 0, (j-1)*(serp_gap_z(p) + serp_chan_height(p))])
            serpentine_channel_circ(
                n=serp_nx(p), 
                l=serp_l(p), 
                gap=serp_gap_x(p), 
                cross_section=[serp_chan_width(p), serp_chan_height(p)], 
                clr=clr
            );
        if (j != serp_nz(p)) {
            if (serp_is_odd(j)){
                _position_odd = [
                    (serp_gap_x(p) + serp_chan_width(p)) * (serp_nx(p) - 1), 
                    serp_l(p) * (serp_nx(p) % 2), 
                    (j-1) * (serp_gap_z(p) + serp_chan_height(p)) - 0.5*serp_chan_height(p)];
                color(clr_vert) 
                    translate(_position_odd) 
                        _serp_vertical_connector(serp_chan_width(p), serp_chan_height(p), serp_gap_z(p));
            }
            else {
                _position_even = [0, 0, (j-1) * (serp_gap_z(p) + serp_chan_height(p)) - 0.5*serp_chan_height(p)];
                color(clr_vert) 
                    translate(_position_even) 
                        _serp_vertical_connector(serp_chan_width(p), serp_chan_height(p), serp_gap_z(p));
            }
        }
    }
}

serpentine3D();
