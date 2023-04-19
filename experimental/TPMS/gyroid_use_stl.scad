unit_cell_size = [1, 1, 1];

module gyroid_unit_cell_from_stl(file) {
    import(file);
}

num_x = 4;
num_y = 4;
num_z = 3;
// file = "n10_C0.stl";
file = "n20_C0.stl";

for(i=[0:num_x-1]){
    for(j=[0:num_y-1]){
        for(k=[0:num_z-1]){
            translate([i*unit_cell_size[0], j*unit_cell_size[1], k*unit_cell_size[2]]) gyroid_unit_cell_from_stl(file);
        }
    }
}


// color("Green") gyroid_unit_cell_from_stl("n10_C0.stl");
// color("red") translate([unit_cell_size[0], 0, 0]) gyroid_unit_cell_from_stl("n10_C0.stl");
// color("blue") translate([0, unit_cell_size[1], 0]) gyroid_unit_cell_from_stl("n10_C0.stl");
// color("HotPink") translate([unit_cell_size[0], unit_cell_size[1], 0]) gyroid_unit_cell_from_stl("n10_C0.stl");
// translate([0, 0, unit_cell_size[2]]) {
//     color("LightGreen") gyroid_unit_cell_from_stl("n10_C0.stl");
//     color("IndianRed") translate([unit_cell_size[0], 0, 0]) gyroid_unit_cell_from_stl("n10_C0.stl");
//     color("dodgerblue") translate([0, unit_cell_size[1], 0]) gyroid_unit_cell_from_stl("n10_C0.stl");
//     color("pink") translate([unit_cell_size[0], unit_cell_size[1], 0]) gyroid_unit_cell_from_stl("n10_C0.stl");
// }
