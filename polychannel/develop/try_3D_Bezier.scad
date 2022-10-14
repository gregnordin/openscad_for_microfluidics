use <../polychannel.scad>

function c0(p0) = p0;
function c1(p0, d0) = p0 + d0 / 3;
function c2(p1, d1) = p1 - d1 / 3;
function c3(p1) = p1;
function p(t, p0, p1, d0, d1) = 
    c0(p0) * ((1 - t)^3) +
    c1(p0, d0) * 3 * t * ((1 - t)^2) + 
    c2(p1, d1) * 3 * t^2 * (1 - t) + 
    c3(p1) * t^3;
function dp(t, p0, p1, d0, d1) = 
    -3 * c0(p0) * (1 - t)^2 +
    3 * c1(p0, d0) * (t * (2*t - 2) + (1 - t)^2) +
    3 * c2(p1, d1) * (-1 * t^2 + 2 * t * (1 - t)) +
    3 * c3(p1) * t^2;

// def dp(t, c0, c1, c2, c3):
//     a0 = -3 * c0 * (1 - t)**2
//     a1 = 3 * c1 * (t * (2*t - 2) + (1 - t)**2)
//     a2 = 3 * c2 * (-1 * t**2 + 2 * t * (1 - t))
//     a3 = 3 * c3 * t**2
//     return a0 + a1 + a2 + a3

p0 = [0, 0, 0];
d0 = [5, 0, 0];
p1 = [3, 2, 0];
d1 = [5, 0, 0];
echo();
echo(c0(p0));
echo(c1(p0, d0));
echo(c2(p1, d1));
echo(c3(p1));
echo(3^3);
size_cube = [1, 1, 1];
n_steps = 100;
for (i=[0:1:n_steps]) {
    // echo(p(i/n_steps, p0, p1, d0, d1));
    translate(p(i/n_steps, p0, p1, d0, d1)) scale(0.05) cube(size_cube, center=true);
}
echo();

t_test = 0.5;
scale_test = 0.06;
p_t_test = p(t_test, p0, p1, d0, d1);
dp_t_test = dp(t_test, p0, p1, d0, d1);
dp_t_test_norm = dp_t_test / norm(dp_t_test);
echo("Tangent vector:", dp_t_test);
color("red")
hull() {
    translate(p_t_test) scale(scale_test) cube(size_cube, center=true);
    translate(p_t_test + dp_t_test_norm) scale(scale_test) cube(size_cube, center=true);
}

eps = 0.01;
plate_size = [eps, 0.3, 0.2];
plate_norm = [1, 0, 0];
color("Salmon") cube(plate_size, center=true);

function _dot(v1, v2, idx) = 
    v1[idx] * v2[idx] + (idx > 0 ? _dot(v1, v2, idx-1) : 0);

function dot(v1, v2) = _dot(v1, v2, len(v1)-1);
function angle_btwn_vecs( v1, v2) = acos(dot(v1, v2) / (norm(v1) * norm(v2)));

echo("dot", dot([1, 0, 0], [5, 1, 0]));
echo("angle", angle_btwn_vecs([1, 0, 0], [1, 1, 0]));

echo(cross(plate_norm, dp_t_test_norm));
rot_axis = cross(plate_norm, dp_t_test_norm) / norm(cross(plate_norm, dp_t_test_norm));
echo(rot_axis);
rot_angle = angle_btwn_vecs(plate_norm, dp_t_test);
echo(rot_angle);

color("Salmon") translate(p_t_test) rotate(a=rot_angle, v=rot_axis) cube(plate_size, center=true);
