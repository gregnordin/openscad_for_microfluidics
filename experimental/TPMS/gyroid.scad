// Create gyroid unit cell in unit cube (in mm) centered on origin. Divide up each x,y,z
// dimension in an integer number of boxes, (nx, ny, nz), such that the unit cube is 
// comprised of nx*ny*nz rectangular boxes. 
// Given a nodal equation f(x,y,z) = C, iterate through the center of each box position
// and create a box if the nodal equation is less than C.
echo();
echo();

// User selectable parameters
n = [4, 4, 4];
C = 0.6;

// Don't change anything below here
unit_cell_size = [1, 1, 1];
unit_cell_center = [0, 0, 0];
box_size = divide_vectors(unit_cell_size, n);
echo("box_size:", box_size);
echo(positions(4));
echo(positions(4, 2));
x_positions = positions(n[0]);
y_positions = positions(n[1]);
z_positions = positions(n[2]);
echo("x_positions:", x_positions);
echo("y_positions:", y_positions);
echo("z_positions:", z_positions);

function divide_vectors(a, b) = [
    a[0] / b[0],
    a[1] / b[1],
    a[2] / b[2]
];

function positions(n, size=1) = 
    let (width = 1/n, start=-(n-1)/(2*n))
[
    for (i=[0:1:n-1])
        (start + i*width) * size
];

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
