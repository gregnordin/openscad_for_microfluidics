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
    translate(p(i/n_steps, p0, p1, d0, d1)) scale(0.05) cube(size_cube);
}
echo();

t_test = 0.5;
scale_test = 0.06;
p_t_test = p(t_test, p0, p1, d0, d1);
dp_t_test = dp(t_test, p0, p1, d0, d1);
color("red")
hull() {
    translate(p_t_test) scale(scale_test) cube(size_cube);
    translate(p_t_test + dp_t_test/norm(dp_t_test)) scale(scale_test) cube(size_cube);
}

echo(norm([1, 1, 0]));