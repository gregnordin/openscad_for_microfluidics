use <../polychannel.scad>


// Example
p0 = [0, 0, 0];
d0 = [5, 0, 0];
p1 = [3, 2, 1];
d1 = [5, 0, 0];
echo();
echo();
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

// Cubic Bezier polychannel connecting two points in 3D
translate([0, -2, 0]) polychannel(
    cubicBezier3D_list("cube", [eps, 0.3, 0.2], 0.5, p0, p1, d0, d1, plate_norm, 30)
);
