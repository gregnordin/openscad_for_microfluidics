use <gyroid.scad>
echo();
echo();

// User selectable parameters
num_ea_dim = 20;
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

create_gyroid_unit_cell(x_positions, y_positions, z_positions, scale=scale, C=C);
