use <../polychannel.scad>

$fn=30;

eps = 0.01;

n = 20;
shape_normal_vec = [0, 1, 0];

shape_0 = "cube";
size_0 = [1, eps, 0.5];
p0 = [0, 0, 0];

shape_1 = "sphere";
size_1 = size_0; // [0.5, eps, 1];
p1 = [4, 3, 4];

distance_p0_p1 = norm(p1 - p0);

d_factor = 1.5;
d0 = [0, d_factor * distance_p0_p1, 0];
d1 = [0, d_factor * distance_p0_p1, 0];

params = cubicBezier3D_list(shape_0, size_0, shape_1, size_1, p0, p1, d0, d1, shape_normal_vec, n);
echo(params);
polychannel(params);
