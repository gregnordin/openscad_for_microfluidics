/*--------------------------------------------------------------------------------------
/ 3D serpentine channel library for single layer or multi-layer
/ serpentine channels.
/
/ For each serpentine channel layer the long channel axis is y. As more long channel 
/ segments are added, the serpentine channel grows in x. Multi-layer serpentine
/ channels are stacked in z.
/
/ Rev. 1, 11/24/23, by G. Nordin
--------------------------------------------------------------------------------------*/
use <serpentine.scad>
use <serpentinecircularends.scad>

$fn = 100;

// Default parameters
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

// Functions to extract individual parameters
function serp_nx(p=default_params) = p[0];
function serp_l(p=default_params) = p[1];
function serp_gap_x(p=default_params) = p[2];
function serp_chan_width(p=default_params) = p[3];
function serp_chan_height(p=default_params) = p[4];
function serp_nz(p=default_params) = p[5];
function serp_gap_z(p=default_params) = p[6];

// Serpentine channel start and end positions
function serp_start_position(p=default_params) = [0, 0, 0];
function serp_end_position(p=default_params) = serp_is_odd(serp_nz(p))
    ?
    [
        (serp_gap_x(p) + serp_chan_width(p)) * (serp_nx(p) - 1), 
        serp_l(p) * (serp_nx(p) % 2), 
        (serp_nz(p)-1) * (serp_gap_z(p) + serp_chan_height(p))
    ] 
    :
    [0, 0, (serp_nz(p)-1) * (serp_gap_z(p) + serp_chan_height(p))];

// Utilities
function serp_is_even(x) = true ? x%2 == 0 : false;
function serp_is_odd(x) = true ? x%2 == 1 : false;
module _serp_vertical_connector(w, h, gap_z) {
    l = gap_z + 2 * h;
    translate([0, 0, 0.5 * l]) cube([w, w, l], center=true);
}

// Main module
module serpentine3D(
    p=default_params,
    circular_ends=true,
    clr="cornflowerblue", 
    clr_vert="blue",
    clr_connection_points="red",
    show_connection_points=false
) {
    for (j=[1:serp_nz(p)]) {
        _layer_vertical_position = [0, 0, (j-1)*(serp_gap_z(p) + serp_chan_height(p))];
        if (circular_ends)
            translate(_layer_vertical_position)
                serpentine_channel_circ(
                    n=serp_nx(p), 
                    l=serp_l(p), 
                    gap=serp_gap_x(p), 
                    cross_section=[serp_chan_width(p), serp_chan_height(p)], 
                    clr=clr
                );
        else
            translate(_layer_vertical_position)
                serpentine_channel(
                    n=serp_nx(p), 
                    l=serp_l(p), 
                    gap=serp_gap_x(p), 
                    size=[serp_chan_width(p), serp_chan_width(p), serp_chan_height(p)], 
                    clr=clr
                );
        if (j != serp_nz(p)) {
            _position = serp_is_odd(j) ?
                [
                    (serp_gap_x(p) + serp_chan_width(p)) * (serp_nx(p) - 1), 
                    serp_l(p) * (serp_nx(p) % 2), 
                    (j-1) * (serp_gap_z(p) + serp_chan_height(p)) - 0.5*serp_chan_height(p)
                ]
            :
                [0, 0, (j-1) * (serp_gap_z(p) + serp_chan_height(p)) - 0.5*serp_chan_height(p)];
            color(clr_vert) 
                    translate(_position) 
                        _serp_vertical_connector(serp_chan_width(p), serp_chan_height(p), serp_gap_z(p));
        }
    }
    if (show_connection_points) {
        _r = 0.25 * serp_chan_height(p);
        color(clr_connection_points) translate(serp_start_position(p)) sphere(r=_r);
        color(clr_connection_points) translate(serp_end_position(p)) sphere(r=_r);
    }
}

// Example code

// 3D serpentines using default parameters
serpentine3D(show_connection_points=true);
translate([-15, 0, 0]) 
    serpentine3D(circular_ends=false, clr="lightblue", show_connection_points=true);

// Single layer serpentines
params_single_layer = [
    default_nx,
    default_l,
    default_gap_x,
    default_chan_width,
    default_chan_height,
    1,
    default_gap_z
];
translate([0, -20, 0]) {
    serpentine3D(p=params_single_layer, show_connection_points=true);
    translate([-15, 0, 0]) 
        serpentine3D(p=params_single_layer, circular_ends=false, clr="lightblue", show_connection_points=true);
};
