// See [is_nan()](https://forum.openscad.org/is-nan-td28336.html) 
// for a discussion about why the following user defined function works.

nan2 = 0/0; 
inf = 1/0; 
ninf = -1/0; 
echo(inf, ninf, nan2); 
function is_nan(x) = x!=x;
echo(is_nan(nan2));
echo(is_nan(0/0));
echo(is_nan(3));

translate([0, 0, 2]) rotate(45, [0, 0, 0]) cube(1, center=true);
