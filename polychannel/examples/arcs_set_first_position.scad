use <../polychannel.scad>

eps=0.01;

n_segs90 = 12;
radius = 1.5;
width = 1.5;
height = 1;
size_for_arc_xy = [width, eps, height];
size_for_arc_xz = [height, width, eps];
size_for_arc_yz = [width, height, eps];
size_yz = [eps, width, height];

params_channel_with_arcs = [
    cube_shape(size_yz, [0, 0, 0]),
    each set_first_position(arc_xy("cube", size_for_arc_xy, radius, -90, 90, n_segs90), pos=[10, 0, 0]),
    each set_first_position(arc_yz("cube", size_for_arc_yz, radius, -90, 180, 2*n_segs90), pos=[0, 4, 0]),
    each set_first_position(arc_xy("cube", size_for_arc_xy, radius, 0, -90, n_segs90), pos=[0, -1.5, 0]),
    each set_first_position(arc_xz("cube", size_for_arc_xz, radius/1.5, 90, 90, n_segs90), pos=[-0.5, 0, 0]),
    each arc_xz("cube", size_for_arc_xz, radius/1.5, 0, -90, n_segs90),
    cube_shape(size_yz, [-7.5, 0, 0]),
];

polychannel(params_channel_with_arcs, clr="Salmon", show_only_shapes=true);
translate([0, 10, 0]) 
    polychannel(params_channel_with_arcs);

echo();
echo();
echo(get_final_position(params_channel_with_arcs));
echo();