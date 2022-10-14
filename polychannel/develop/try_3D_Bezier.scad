use <../polychannel.scad>

function c0(p0) = p0;
function c1(p0, d0) = p0 + d0 / 3;
function c2(p1, d1) = p1 - d1 / 3;
function c3(p1) = p1;
function cubicBezier3D_point(t, p0, p1, d0, d1) = 
    c0(p0) * ((1 - t)^3) +
    c1(p0, d0) * 3 * t * ((1 - t)^2) + 
    c2(p1, d1) * 3 * t^2 * (1 - t) + 
    c3(p1) * t^3;
function cubicBezier3D_point_tangent(t, p0, p1, d0, d1) = 
    -3 * c0(p0) * (1 - t)^2 +
    3 * c1(p0, d0) * (t * (2*t - 2) + (1 - t)^2) +
    3 * c2(p1, d1) * (-1 * t^2 + 2 * t * (1 - t)) +
    3 * c3(p1) * t^2;

function unit_vec(v) = v / norm(v); 
function angle_btwn_vecs( v1, v2) = acos(v1 * v2 / (norm(v1) * norm(v2)));


// Example
p0 = [0, 0, 0];
d0 = [8, 0, 0];
p1 = [3, 2, 1];
d1 = [8, 0, 0];
echo();
echo(c0(p0));
echo(c1(p0, d0));
echo(c2(p1, d1));
echo(c3(p1));
size_cube = [1, 1, 1];

// Draw Bezier curve
n_steps = 100;
for (i=[0:1:n_steps]) {
    translate(cubicBezier3D_point(i/n_steps, p0, p1, d0, d1)) scale(0.05) cube(size_cube, center=true);
}
echo();

// Draw tangent and transverse rotated plate at a test point
t_test = 0.5;
p_t_test = cubicBezier3D_point(t_test, p0, p1, d0, d1);
dp_t_test = cubicBezier3D_point_tangent(t_test, p0, p1, d0, d1);
dp_t_test_norm = dp_t_test / norm(dp_t_test);
scale_test = 0.06;
// Tangent vector
echo("Tangent vector:", dp_t_test);
color("red")
    hull() {
        translate(p_t_test) scale(scale_test) cube(size_cube, center=true);
        translate(p_t_test + dp_t_test_norm) scale(scale_test) cube(size_cube, center=true);
    }
// Plate
eps = 0.01;
plate_size = [eps, 0.3, 0.2];
plate_norm = [1, 0, 0];
// First show original plate at origin
color("Salmon") cube(plate_size, center=true);
// Now show translated and rotated plate
rot_angle = angle_btwn_vecs(plate_norm, dp_t_test_norm);
rot_axis = unit_vec(cross(plate_norm, dp_t_test_norm));
echo("Rotation angle", rot_angle);
echo("Rotation axis", rot_axis);
color("Salmon") translate(p_t_test) rotate(a=rot_angle, v=rot_axis) cube(plate_size, center=true);

function cubicBezier3D_one_line(shape, size, t, p0, p1, d0, d1, shape_normal_vec) = [
    shape, 
    size, 
    cubicBezier3D_point(t, p0, p1, d0, d1),
    [
        angle_btwn_vecs(shape_normal_vec, cubicBezier3D_point_tangent(t, p0, p1, d0, d1)),
        unit_vec(cross(shape_normal_vec, cubicBezier3D_point_tangent(t, p0, p1, d0, d1)))
    ]
];
function _cubicBezier3D_list(shape, size, t, p0, p1, d0, d1, shape_normal_vec, n) = [
    for (i=[0:1:n]) 
        let (t=i/n) 
        cubicBezier3D_one_line("cube", [eps, 0.3, 0.2], t, p0, p1, d0, d1, plate_norm),
];
function cubicBezier3D_list(shape, size, t, p0, p1, d0, d1, shape_normal_vec, n) = 
    abs_to_rel_positions(
        _cubicBezier3D_list(shape, size, t, p0, p1, d0, d1, shape_normal_vec, n)
    );

echo(cubicBezier3D_one_line("cube", [eps, 0.3, 0.2], 0.5, p0, p1, d0, d1, plate_norm));
echo(_cubicBezier3D_list("cube", [eps, 0.3, 0.2], 0.5, p0, p1, d0, d1, plate_norm, 4));
echo();
echo(cubicBezier3D_list("cube", [eps, 0.3, 0.2], 0.5, p0, p1, d0, d1, plate_norm, 4));

translate([0, -2, 0]) polychannel(
    cubicBezier3D_list("cube", [eps, 0.3, 0.2], 0.5, p0, p1, d0, d1, plate_norm, 20)
);
