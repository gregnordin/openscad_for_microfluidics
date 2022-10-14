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
for (i=[0:1:10]) {
    // echo(p(i*0.1, p0, p1, d0, d1));
    translate(p(i*0.1, p0, p1, d0, d1)) scale(0.1) cube(size_cube);
}
echo();
