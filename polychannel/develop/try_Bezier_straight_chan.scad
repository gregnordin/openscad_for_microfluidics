use <../polychannel.scad>

// Purpose: try using cubic Bezier curve for straight channel and
// Try 45 deg rotated plates for 90 deg bends.

// function straight_channel(width, height, length, direction, starting_position=[0, 0, 0], eps=0.01) = 
//     cubicBezier3D_list(
//         "cube", 
//         [eps, width, height], 
//         starting_position, 
//         length * unit_vec(direction), 
//         direction, 
//         direction, 
//         [1, 0, 0], 
//         1
//     );

function straight_channel_xy(width, height, length, direction, starting_position=[0, 0, 0], eps=0.01) = 
    set_first_position(
        cubicBezier3D_list(
            "cube", 
            [eps, width, height], 
            [0, 0, 0], 
            length * unit_vec(direction), 
            direction, 
            direction, 
            [1, 0, 0], 
            1
        ), 
        pos=starting_position
    );

function straight_channel_xz(width, height, length, direction, starting_position=[0, 0, 0], eps=0.01) = 
    straight_channel_xy(width, height, length, direction, starting_position=starting_position, eps=eps);

function straight_channel_yz(width, height, length, direction, starting_position=[0, 0, 0], eps=0.01) = 
    set_first_position(
        cubicBezier3D_list(
            "cube", 
            [width, eps, height], 
            [0, 0, 0], 
            length * unit_vec(direction), 
            direction, 
            direction, 
            [0, 1, 0], 
            1
        ), 
        pos=starting_position
    );

width = 2;
height = 1.5;
length = 5;

// xy channels
polychannel(
    straight_channel_xy(width, height, length, [1, 0, 0])
);
polychannel(
    straight_channel_xy(width, height, length, [1, 1, 0]),
    clr="Salmon"
);
polychannel(
    straight_channel_xy(width, height, length, [0, 1, 0]),
    clr="Aquamarine"
);
polychannel(
    straight_channel_xy(width, height, length, [-1, 1, 0]),
    clr="Violet"
);
polychannel(
    straight_channel_xy(width, height, length, [-1, 0, 0]),
    clr="Gray"
);
polychannel(
    straight_channel_xy(width, height, length, [-1, -1, 0]),
    clr="Tan"
);
polychannel(
    straight_channel_xy(width, height, length, [0, -1, 0]),
    clr="SandyBrown"
);
polychannel(
    straight_channel_xy(width, height, length, [1, -1, 0]),
    clr="RosyBrown"
);
echo(straight_channel_xy(width, height, length, [1, 1, 0], starting_position=[8, 2, 0]));
polychannel(
    straight_channel_xy(width, height, length, [1, 1, 0], starting_position=[8, 2, 0]),
    clr="SteelBlue"
);

// xz channels
translate([-20, 0, 0]) {
    polychannel(
        straight_channel_xz(width, height, length, [1, 0, 0])
    );
    polychannel(
        straight_channel_xz(width, height, length, [1, 0, 1]),
        clr="Salmon"
    );
    polychannel(
        straight_channel_xz(width, height, length, [0, 0, 1]),
        clr="Aquamarine"
    );
    polychannel(
        straight_channel_xz(width, height, length, [-1, 0, 1]),
        clr="Violet"
    );
    polychannel(
        straight_channel_xz(width, height, length, [-1, 0, 0]),
        clr="Gray"
    );
    polychannel(
        straight_channel_xz(width, height, length, [-1, 0, -1]),
        clr="Tan"
    );
    polychannel(
        straight_channel_xz(width, height, length, [0, 0, -1]),
        clr="SandyBrown"
    );
    polychannel(
        straight_channel_xz(width, height, length, [1, 0, -1]),
        clr="RosyBrown"
    );
    echo(straight_channel_xz(width, height, length, [1, 0, 1], starting_position=[8, 2, 0]));
    polychannel(
        straight_channel_xz(width, height, length, [1, 0, 1], starting_position=[8, 2, 0]),
        clr="SteelBlue"
    );
}

// yz channels
translate([0, 20, 0]) {
    polychannel(
        straight_channel_yz(width, height, length, [0, 1, 0])
    );
    polychannel(
        straight_channel_yz(width, height, length, [0, 1, 1]),
        clr="Salmon"
    );
    polychannel(
        straight_channel_yz(width, height, length, [0, 0, 1]),
        clr="Aquamarine"
    );
    polychannel(
        straight_channel_yz(width, height, length, [0, -1, 1]),
        clr="Violet"
    );
    polychannel(
        straight_channel_yz(width, height, length, [0, -1, 0]),
        clr="Gray"
    );
    polychannel(
        straight_channel_yz(width, height, length, [0, -1, -1]),
        clr="Tan"
    );
    polychannel(
        straight_channel_yz(width, height, length, [0, 0, -1]),
        clr="SandyBrown"
    );
    polychannel(
        straight_channel_yz(width, height, length, [0, 1, -1]),
        clr="RosyBrown"
    );
    echo(straight_channel_yz(width, height, length, [0, 1, 1], starting_position=[-2, 8, 0]));
    polychannel(
        straight_channel_yz(width, height, length, [0, 1, 1], starting_position=[-2, 8, 0]),
        clr="SteelBlue"
    );
}
