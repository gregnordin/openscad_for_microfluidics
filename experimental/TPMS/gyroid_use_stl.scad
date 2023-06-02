unit_cell_size = [1, 1, 1];
scale = [1, 1, 1];

module create_gyroid_unit_cell_from_stl(file, scale=[1,1,1]) {
    import(file);
}

num_x = 5;
num_y = 4;
num_z = 3;
file = "stl_experiments/n10_C0.stl";
// file = "stl_experiments/n20_C0.stl";
colors = ["IndianRed", "LightGreen"];

difference() {
    for(i=[0:num_x-1]){
        for(j=[0:num_y-1]){
            for(k=[0:num_z-1]){
                color(colors[(i+j+k) % 2])
                translate([i*unit_cell_size[0], j*unit_cell_size[1], k*unit_cell_size[2]]) 
                    scale(scale) 
                        create_gyroid_unit_cell_from_stl(file);
            //     echo((i+j+k) % 2);
            //     echo(colors[(i+j+k) % 2]);
            }
        }
    };
    translate([-1, -1, 2.55 - z_position($t)]) cube([8, 8, 8]);
}

function z_position(t) = t < 3
    ? t * 3
    : 3;

echo($t);
echo(z_position($t));


// color("Green") create_gyroid_unit_cell_from_stl("n10_C0.stl");
// color("red") translate([unit_cell_size[0], 0, 0]) create_gyroid_unit_cell_from_stl("n10_C0.stl");
// color("blue") translate([0, unit_cell_size[1], 0]) create_gyroid_unit_cell_from_stl("n10_C0.stl");
// color("HotPink") translate([unit_cell_size[0], unit_cell_size[1], 0]) create_gyroid_unit_cell_from_stl("n10_C0.stl");
// translate([0, 0, unit_cell_size[2]]) {
//     color("LightGreen") create_gyroid_unit_cell_from_stl("n10_C0.stl");
//     color("IndianRed") translate([unit_cell_size[0], 0, 0]) create_gyroid_unit_cell_from_stl("n10_C0.stl");
//     color("dodgerblue") translate([0, unit_cell_size[1], 0]) create_gyroid_unit_cell_from_stl("n10_C0.stl");
//     color("pink") translate([unit_cell_size[0], unit_cell_size[1], 0]) create_gyroid_unit_cell_from_stl("n10_C0.stl");
// }
