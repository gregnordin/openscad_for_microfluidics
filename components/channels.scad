default_layer = 0.010;
default_px = 0.0076;
default_channel_width = 12*default_px;
default_channel_height = 10*default_layer;

module xchan(l, w=default_channel_width, h=default_channel_height, px=default_px, clr="red") {
    centered_y_position = [0, -floor(w / px / 2) * px, 0];
    echo(w/px, centered_y_position[1]/px);
    color(clr)
        if (l < 0)
            mirror([1, 0, 0])
                translate(centered_y_position) cube([-l, w, h]);
            else
        translate(centered_y_position) cube([l, w, h]);
}

module ychan(l, w=default_channel_width, h=default_channel_height, px=default_px, clr="green") {
    centered_x_position = [-floor(w / px / 2) * px, 0, 0];
    echo(w/px, centered_x_position[0]/px);
    color(clr)
        if (l < 0)
            mirror([0, -1, 0])
                translate(centered_x_position) cube([w, -l, h]);
            else
        translate(centered_x_position) cube([w, l, h]);
}

module zchan(l, xy=default_channel_width, px=default_px, clr="blue") {
    centered_xy_position = [-floor(xy / px / 2) * px, -floor(xy / px / 2) * px, 0];
    // echo(xy/px, centered_xy_position[0]/px);
    // echo(xy/px, centered_xy_position[1]/px);
    color(clr)
        translate(centered_xy_position) {
            if (l < 0)
                mirror([0, 0, 1])
                    cube([xy, xy, -l]);
                else
            cube([xy, xy, l]);
        }
}

temp_l = 65*default_px;
// echo(temp_l);   // 0.494 mm
// Test for channels with widths that are odd number of pixels
xchan(temp_l, w=8*default_px, h=5*default_layer, clr="red");
ychan(temp_l, w=13*default_px, clr="green");
zchan(temp_l, xy=5*default_px, clr="blue");