// Create gyroid unit cell in unit cube (in mm) centered on origin. Divide up each x,y,z
// dimension in an integer number of boxes, (nx, ny, nz), such that the unit cube is 
// comprised of nx*ny*nz rectangular boxes. 
// Given a nodal equation f(x,y,z) = C, iterate through the center of each box position
// and create a box if the nodal equation is less than C.
echo();
echo();

// User selectable parameters
num_ea_dim = 10;
n = [num_ea_dim, num_ea_dim, num_ea_dim];
C = 0.0;
scale = 1.0;

// Don't change anything below here
unit_cell_size = [1, 1, 1];
unit_cell_center = [0, 0, 0];
box_size = divide_vectors(unit_cell_size, n);
x_positions = positions(n[0]);
y_positions = positions(n[1]);
z_positions = positions(n[2]);
echo("Number of boxes:", n[0]*n[1]*n[2]);
echo("box_size:", box_size);
echo("x_positions:", x_positions);
echo("y_positions:", y_positions);
echo("z_positions:", z_positions);

function divide_vectors(a, b) = [
    a[0] / b[0],
    a[1] / b[1],
    a[2] / b[2]
];

function positions(n, size=1) = let (width = 1/n, start=-(n-1)/(2*n)) [
    for (i=[0:1:n-1])
        (start + i*width) * size
];

module box(x=0, y=0, z=0, scale=1) {
    translate([x, y, z]) cube(box_size * scale, center=true);
}

module test_box(x=0, y=0, z=0) {
    box(x, y, z, scale=0.5);
}

// Trig function argument range is [-2*pi, 2*pi] = 4*pi, but we have to use degrees:
range_deg = 2 * 180;
temp_value = -0.2;
echo("gyroid_nodal_eqn:", gyroid_nodal_eqn(temp_value,0,0));
echo("       in_gyroid:", in_gyroid(temp_value,0,0, 0.0));

function gyroid_nodal_eqn(x, y, z) = let(a = range_deg)
    cos(a*x) * sin(a*y) +
    cos(a*y) * sin(a*z) +
    cos(a*z) * sin(a*x);

function in_gyroid(x, y, z, C) = 
    gyroid_nodal_eqn(x, y, z) > C 
        ? true
        : false;

function in_positive_octant(x, y, z) = 
    x > 0 && y > 0 && z > 0
        ? true
        : false;

function is_positive_x(x, y, z) = 
    x > 0 
        ? true
        : false;

module gyroid_unit_cell(scale=1) {
    for (z = z_positions) {
        for (y = y_positions) {
            for (x = x_positions) {
                if (in_gyroid(x, y, z, C))
                // if (is_positive_x(x, y, z))
                // if (in_positive_octant(x, y, z))
                    box(x, y, z, scale=scale);
                    // test_box(x, y, z);
            }
        }
    }
}

// gyroid_unit_cell(scale=0.5);
color("Green") gyroid_unit_cell(scale);
color("red") translate([unit_cell_size[0], 0, 0]) gyroid_unit_cell(scale);
color("blue") translate([0, unit_cell_size[1], 0]) gyroid_unit_cell(scale);
color("HotPink") translate([unit_cell_size[0], unit_cell_size[1], 0]) gyroid_unit_cell(scale);
translate([0, 0, unit_cell_size[2]]) {
    color("LightGreen") gyroid_unit_cell(scale);
    color("IndianRed") translate([unit_cell_size[0], 0, 0]) gyroid_unit_cell(scale);
    color("dodgerblue") translate([0, unit_cell_size[1], 0]) gyroid_unit_cell(scale);
    color("pink") translate([unit_cell_size[0], unit_cell_size[1], 0]) gyroid_unit_cell(scale);
}

// // Initially work in mm while developing code

// // 3D printing parameters
// px = 0.75;
// layer = 1.5;

// // Box size
// box_size = [2 * px, 2 * px, layer];
// assert(box_size[0] == box_size[1], "Box x and y dimensions are not the same");
// assert(box_size[0] == box_size[2], "Box x and 2 dimensions are not the same");
// b = box_size[0];

// // Gyroid unit cell size

// unit_cell_size_in_num_boxes = 10;
// assert(unit_cell_size_in_num_boxes % 1 == 0, "This must be an integer");
// u = unit_cell_size_in_num_boxes * b;


// echo("unit_cell_size:", u);
// echo("box size:", b);
// echo("unit_cell_size_in_num_boxes:", unit_cell_size_in_num_boxes);
