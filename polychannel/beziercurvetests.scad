 //use <C:\Users\mjame\OneDrive - Brigham Young University\Desktop\LAB ON A CHIP\openscad_for_microfluidics-main\openscad_for_microfluidics-main\polychannel\polychannel.scad>
  use <C:\Users\mjame\OneDrive - Brigham Young University\Desktop\LAB ON A CHIP\openscad_for_microfluidics-main\openscad_for_microfluidics-main\polychannel\polychannel_Vers_Marsh.scad>
/*shapes = [
["cube",[eps, 4, 4], [0,0,0], no_rotation],
["cube", [eps, 5, 5], [10,0,0], no_rotation],
["sphr", [eps, 2, 4], [0,0,10], no_rotation],
["sphr", [eps, 6, 6], [-10,0,0], no_rotation],
["cube",[eps, 4, 4], [0,0,-10], no_rotation]
];
polychannel(shapes, clr="yellow", show_only_shapes=false);
*/

//toggle here to show what you want to show
show_random_channels = false;
show_chip_demo = true;

eps = .01;
no_rotation = no_rot();
if (show_random_channels) {
    n_segs90 = 10;
    params_verbose = [
        ["sphr", [eps, 4, 4], [0, 0, 0], no_rotation],
        ["sphr", [eps, 4, 4], [7, 0, 0], no_rotation],
        ["sphr", [eps, 3, 3], [0, 0, 0], no_rotation],
        ["cube", [eps, 1, 1], [3, 0, 0], no_rotation],
        ["cube", [eps, 1*sqrt(2), 1], [3, 0, 0], rot_z(45)],
        ["cube", [eps, 1, 1], [0, 2, 0], rot_z(90)],
        ["cube", [3, 1, 3], [0, 3, 0], no_rotation],
        ["cube", [1, eps, 1], [0, 2, 0], no_rotation],
        ["sphr", [eps, 1*sqrt(2), 1], [0, 2, 0], rot_z(45)],
        ["sphr", [eps, 2, 2], [5, 0, 0], no_rotation],
        ["sphr", [2, 2, 2], [2, 0, 0], no_rotation],
        ["sphr", [2, 2, 2], [0, -4, 4], no_rotation],
        ["cube", [1, eps, 2], [0, -3, 0], no_rotation],
        each arc_xy("cube", [1, eps, 2], radius=3, angle1=0, delta_angle=-90, n=n_segs90),
        ["cube", [1, 1, 2], [-2, 0, 0], no_rotation],
        each arc_xz("cube", [2, 1, eps], radius=3, angle1=-90, delta_angle=-180, n=2*n_segs90),
        each arc_xy("cube", [1, eps, 2], radius=1, angle1=-90, delta_angle=90, n=n_segs90),
        ["cube", [1, eps, 1], [0, 5, 0], no_rotation],
        each arc_xy("cube", [1, eps, 1], radius=1, angle1=0, delta_angle=90, n=n_segs90),
        ["cube", [eps, 1, 1], [-15, 0, 0], no_rotation],
    ];
    numSegs = 15;
    my_geometry = [
    ["cube", [eps, 1, 5], [0,0,0], no_rotation],
    ["cube", [eps, 5, 1], [7,0,0], no_rotation],
    ["cube", [eps, 5,1], [1,0,0], no_rotation],
    ["cube", [eps, 5,3], [3,0,0], no_rotation],
    ["sphere",[eps, 3,3], [0,0,0], no_rotation],
    ["sphere",[eps, 3*sqrt(2),3], [3,0,0], rot_z(-45)],
    ["sphere",[eps, 3,3], [0,-3,0], rot_z(-90)],
    ["cube",[2, eps, 2], [0,0,0], no_rotation],
    ["cube",[2, eps, 2], [0,-2,0], no_rotation],
    each arc_xy("cube", [1.5, eps, 1.5], radius=4, angle1=180, delta_angle=90, n=numSegs),
    ["sphere",[eps, 1, 1],[3,0,0], no_rotation],
    ["sphere",[eps, 1, 1],[3,0,0], no_rotation],
    each arc_xy("sphere", [2, eps, 2], radius=5, angle1=270, delta_angle=270,n=numSegs),
    each arc_yz("sphere", [2,2,eps], radius = 3, angle1 = -90, delta_angle = -90, n=numSegs-10),
    ["cube", [2,2,eps], [0,0,2], no_rotation],
    each arc_xz("cube", [2,2,eps], radius = 4, angle1 = 0, delta_angle = 90, n=numSegs-10),
    ["cube", [eps,.5,.5], [-3,0,0], no_rotation]

    ];

    polychannel(params_verbose, clr = "red", show_only_shapes=false);
    translate([0,25,0]) polychannel(params_verbose, clr = "pink", show_only_shapes=true);
    translate([0,-10,0]) color("skyblue") polychannel(my_geometry, clr = "blue", show_only_shapes = false);

    //Isn't being recognized by compiler
    //translate([0,-50,0]) cubicBezier3D_one_line("cube", [2,2,2], 5, [0,0,0], [10, 4, 0], [1,2,3],[3,4,5], 1);
    /*---------------------------------------------------------------------------------------
    // Cubic Bezier curve to connect two 3D points.
    //  p0 - Initial position
    //  p1 - Final position
    //  d0 - Tangent of curve at initial position
    //  d1 - Tangent of curve at final position
    //  n - Number of segments in curve, so number of points in curve is n+1.
    /--------------------------------------------------------------------------------------*/
    trans = 10;
    //PINK 1


    translate([0, -3 * trans, 0]) {
            p0 = [0, 0, 0];
        d0 = [0, 0, 0];
        p1 = [20, 0, 0];
        d1 = [0, 0, 0];
        size_0 = [eps, 1, 1];
        size_1 = [eps, 4, 4];
        n_steps = 10;
        plate_norm = [1,0,0];
        plate_size = [eps, 1.3, 1.3];
        color("pink") translate([0,3,0]) polychannel(cubicBezier3D_list("cube", size_0, size_1, p0, p1, d0, d1,plate_norm,n_steps));
        translate([0,0,10]) polychannel(concat(cubicBezier3D_list("cube", size_0, size_1, p0, p1, d0, d1,plate_norm,n_steps), cubicBezier3D_list("cube", size_0, size_1, p0, p1, d0, d1,plate_norm,n_steps)));
            // the skeleton
        size_cube = [.01,.3,.3];
        scale_test = .65;
        color("purple")
        for (i=[0:1:n_steps]) {
            translate(cubicBezier3D_point(i/n_steps, p0, p1, d0, d1)) scale(scale_test) cube(size_cube, center=true);
        }
        t_test = 0.5;
        p_t_test = cubicBezier3D_point(t_test, p0, p1, d0, d1);
        dp_t_test = cubicBezier3D_point_tangent(t_test, p0, p1, d0, d1);
        echo("dp_t_test:",dp_t_test);
        dp_t_test_norm = dp_t_test / norm(dp_t_test);
        // Tangent vector
        echo("Tangent vector:", dp_t_test);
        color("red")
            hull() {
                translate(p_t_test) scale(scale_test) cube(size_cube, center=true);
            translate(p_t_test + dp_t_test_norm) scale(scale_test) cube(size_cube, center=true);
            }
    }
    //PINK 2
    translate([0, -4.0 * trans, 0]) {
            p0 = [0, 0, 0];
        d0 = [40, 0, 0];
        p1 = [40, 0, 20];
        d1 = [40, 0, 0];
        size_0 = [eps, 1, 1];
        size_1 = [eps, 6, 2];
        n_steps = 40;
        plate_norm = [1,0,0];
        plate_size = [eps, 1.3, 1.3];
        color("pink") translate([0,3,0]) polychannel(cubicBezier3D_list("cube", size_0, size_1, p0, p1, d0, d1,plate_norm,n_steps));

            // the skeleton
        size_cube = [.01,.3,.3];
        scale_test = .65;
        color("purple")
        for (i=[0:1:n_steps]) {
            translate(cubicBezier3D_point(i/n_steps, p0, p1, d0, d1)) scale(scale_test) cube(size_cube, center=true);
        }
        t_test = 0.5;
        p_t_test = cubicBezier3D_point(t_test, p0, p1, d0, d1);
        dp_t_test = cubicBezier3D_point_tangent(t_test, p0, p1, d0, d1);
        echo("dp_t_test:",dp_t_test);
        dp_t_test_norm = dp_t_test / norm(dp_t_test);
        // Tangent vector
        echo("Tangent vector:", dp_t_test);
        color("red")
            hull() {
                translate(p_t_test) scale(scale_test) cube(size_cube, center=true);
            translate(p_t_test + dp_t_test_norm) scale(scale_test) cube(size_cube, center=true);
            }
    }
    // PINK 3
    translate([0, -5.0*trans, 0]) {
            p0 = [0, 0, 0];
        d0 = [40, 0, 0];
        p1 = [40, 10, 0];
        d1 = [40, 0, 0];
        size_0 = [eps, 1, 1];
        size_1 = [eps, 6, 2];
        n_steps = 40;
        plate_norm = [1,0,0];
        plate_size = [eps, 1.3, 1.3];
        color("pink") translate([0,3,0]) polychannel(cubicBezier3D_list("cube", size_0, size_1, p0, p1, d0, d1,plate_norm,n_steps));

            // the skeleton
        size_cube = [.01,.3,.3];
        scale_test = .65;
        color("purple")
        for (i=[0:1:n_steps]) {
            translate(cubicBezier3D_point(i/n_steps, p0, p1, d0, d1)) scale(scale_test) cube(size_cube, center=true);
        }
        t_test = 0.5;
        p_t_test = cubicBezier3D_point(t_test, p0, p1, d0, d1);
        dp_t_test = cubicBezier3D_point_tangent(t_test, p0, p1, d0, d1);
        echo("dp_t_test:",dp_t_test);
        dp_t_test_norm = dp_t_test / norm(dp_t_test);
        // Tangent vector
        echo("Tangent vector:", dp_t_test);
        color("red")
            hull() {
                translate(p_t_test) scale(scale_test) cube(size_cube, center=true);
            translate(p_t_test + dp_t_test_norm) scale(scale_test) cube(size_cube, center=true);
            }
    }
    //PINK #4
    translate([0, -6.0*trans, 0]) {
            p0 = [0, 0, 0];
        d0 = [0, 40, 0];
        p1 = [40, 0, 0];
        d1 = [0, 40, 0];
        size_0 = [eps, 1, 1];
        size_1 = [eps, 6, 6];
        n_steps = 40;
        plate_norm = [1,0,0];
        plate_size = [eps, 1.3, 1.3];
        color("pink") translate([0,3,0]) polychannel(cubicBezier3D_list("cube", size_0, size_1, p0, p1, d0, d1,plate_norm,n_steps));

            // the skeleton
        size_cube = [.01,.3,.3];
        scale_test = .65;
        color("purple")
        for (i=[0:1:n_steps]) {
            translate(cubicBezier3D_point(i/n_steps, p0, p1, d0, d1)) scale(scale_test) cube(size_cube, center=true);
        }
        t_test = 0.5;
        p_t_test = cubicBezier3D_point(t_test, p0, p1, d0, d1);
        dp_t_test = cubicBezier3D_point_tangent(t_test, p0, p1, d0, d1);
        echo("dp_t_test:",dp_t_test);
        dp_t_test_norm = dp_t_test / norm(dp_t_test);
        // Tangent vector
        echo("Tangent vector:", dp_t_test);
        color("red")
            hull() {
                translate(p_t_test) scale(scale_test) cube(size_cube, center=true);
            translate(p_t_test + dp_t_test_norm) scale(scale_test) cube(size_cube, center=true);
            }
    }
    //PINK #5
    translate([0, -7.0*trans, 0]) {
            p0 = [0, 0, 0];
        d0 = [0, 0, -100];
        p1 = [40, 0, 20];
        d1 = [0, 0, 20];
        size_0 = [eps, 1, 1];
        size_1 = [eps, 6, 2];
        n_steps = 40;
        plate_norm = [1,0,0];
        plate_size = [eps, 1.3, 1.3];
    color("pink") translate([0,3,0]) polychannel(cubicBezier3D_list("cube", size_0, size_1, p0, p1, d0, d1,plate_norm,n_steps));

            // the skeleton
        size_cube = [.01,.3,.3];
        scale_test = .65;
        color("purple")
        for (i=[0:1:n_steps]) {
            translate(cubicBezier3D_point(i/n_steps, p0, p1, d0, d1)) scale(scale_test) cube(size_cube, center=true);
        }
        t_test = 0.5;
        p_t_test = cubicBezier3D_point(t_test, p0, p1, d0, d1);
        dp_t_test = cubicBezier3D_point_tangent(t_test, p0, p1, d0, d1);
        echo("dp_t_test:",dp_t_test);
        dp_t_test_norm = dp_t_test / norm(dp_t_test);
        // Tangent vector
        echo("Tangent vector:", dp_t_test);
        color("red")
            hull() {
                translate(p_t_test) scale(scale_test) cube(size_cube, center=true);
            translate(p_t_test + dp_t_test_norm) scale(scale_test) cube(size_cube, center=true);
            }
    }
    //RED 1
    translate([0, -8.0*trans, 0]) {
            p0 = [0, 0, 0];
        d0 = [0, 10, 140];
        p1 = [0, 0, 60];
        d1 = [0, 0, 140];
        size_0 = [eps, 1, 1];
        size_1 = [eps, 10, 50];
        n_steps = 80;
        plate_norm = [1,0,0];
        plate_size = [eps, 1.3, 1.3];
        color("red") translate([0,3,0]) %polychannel(cubicBezier3D_list("cube", size_0, size_1, p0, p1, d0, d1,plate_norm,n_steps));

            // the skeleton
        size_cube = [.01,.3,.3];
        scale_test = .65;
        color("purple")
        for (i=[0:1:n_steps]) {
            translate(cubicBezier3D_point(i/n_steps, p0, p1, d0, d1)) scale(scale_test) cube(size_cube, center=true);
        }
        t_test = 0.5;
        p_t_test = cubicBezier3D_point(t_test, p0, p1, d0, d1);
        dp_t_test = cubicBezier3D_point_tangent(t_test, p0, p1, d0, d1);
        echo("dp_t_test:",dp_t_test);
        dp_t_test_norm = dp_t_test / norm(dp_t_test);
        // Tangent vector
        echo("Tangent vector:", dp_t_test);
        color("red")
            hull() {
                translate(p_t_test) scale(scale_test) cube(size_cube, center=true);
            translate(p_t_test + dp_t_test_norm) scale(scale_test) cube(size_cube, center=true);
            }
    }
    //LIGHT BLUE #1
    translate([0,-10.5*trans,0]) {
        p0 = [0, 0, 0];
        d0 = [10, 20, 3];
        p1 = [20, 5, 0];
        d1 = [5, 20, 2];

        n_steps = 80;
        plate_norm = [1,0,0];
        plate_size = [eps, 1.3, 1.3];
        translate([0,3,0]) polychannel(cubicBezier3D_list("cube", [eps, 1.5, .6], [eps, 3, 6], p0, p1, d0, d1,plate_norm,n_steps));

        // the skeleton
        size_cube = [.01,.3,.3];
        scale_test = .65;
        color("purple")
        for (i=[0:1:n_steps]) {
            translate(cubicBezier3D_point(i/n_steps, p0, p1, d0, d1)) scale(scale_test) cube(size_cube, center=true);
        }
        t_test = 0.5;
        p_t_test = cubicBezier3D_point(t_test, p0, p1, d0, d1);
        dp_t_test = cubicBezier3D_point_tangent(t_test, p0, p1, d0, d1);
        echo("dp_t_test:",dp_t_test);
        dp_t_test_norm = dp_t_test / norm(dp_t_test);
        // Tangent vector
        echo("Tangent vector:", dp_t_test);
        color("red")
            hull() {
                translate(p_t_test) scale(scale_test) cube(size_cube, center=true);
            translate(p_t_test + dp_t_test_norm) scale(scale_test) cube(size_cube, center=true);
            }
    }
    //YELLOW #1
    translate([0, -11.5*trans, 0]) {
            p0 = [0, 0, 0];
        d0 = [100, -20, 0];
        p1 = [20, -20, 20];
        d1 = [-100, 0, 10];

        n_steps = 80;
        plate_norm = [1,0,0];
        plate_size = [eps, 1.3, 1.3];
        color("yellow") translate([0,3,0]) polychannel(cubicBezier3D_list("cube", [eps, 1.5, .6], [eps, 3, 6], p0, p1, d0, d1,plate_norm,n_steps));
            color("yellow") translate([0,-7,0]) polychannel(cubicBezier3D_list("cube", [eps, 1.5, .6], [eps, 3, 6], p0, p1, d0, d1,plate_norm,n_steps), show_only_shapes=true);

            // the skeleton
        size_cube = [.01,.3,.3];
        scale_test = .65;
        color("purple")
        for (i=[0:1:n_steps]) {
            translate(cubicBezier3D_point(i/n_steps, p0, p1, d0, d1)) scale(scale_test) cube(size_cube, center=true);
        }
        t_test = 0.5;
        p_t_test = cubicBezier3D_point(t_test, p0, p1, d0, d1);
        dp_t_test = cubicBezier3D_point_tangent(t_test, p0, p1, d0, d1);
        echo("dp_t_test:",dp_t_test);
        dp_t_test_norm = dp_t_test / norm(dp_t_test);
        // Tangent vector
        echo("Tangent vector:", dp_t_test);
        color("red")
            hull() {
                translate(p_t_test) scale(scale_test) cube(size_cube, center=true);
            translate(p_t_test + dp_t_test_norm) scale(scale_test) cube(size_cube, center=true);
            }
    }

    // Now show translated and rotated plate
    //rot_angle = angle_btwn_vecs(plate_norm, dp_t_test_norm);
    /*rot_axis = unit_vec(cross(plate_norm, dp_t_test_norm));
    echo("Rotation angle", rot_angle);
    echo("Rotation axis", rot_axis);
    color("Salmon") translate(p_t_test) rotate(a=rot_angle, v=rot_axis) cube(plate_size, center=true);*/
}
layer = .01;
px = .0076;
n_steps = 50;
if (show_chip_demo) {

    echo("seg2 ",segment_2);
    difference() {
        %cube([2560*px,1600*px,400*layer]);
        translate([200*px,0,50*layer])
        polychannel(concat(    //shape---- size 0-----------------size_1---------------point_0-----------------point_1--------------------Tan_0------Tan_1---plane--n_steps
            cubicBezier3D_list("cube", [eps, 48*2*px, layer*40*2],[eps, 24*px, layer*20],[0*px, 0, 40*layer],[400*px, 1500*px, 300*layer],[0,12.1,0],[10,0,0],[1,0,0],n_steps),
            cubicBezier3D_list("cube", [eps, 24*px, layer*20],[eps, 24*px, layer*20],[0*px, 0, 0*layer],[(2560-2*600)*px, 0*px, 0*layer],[0,0,0],[0,0,0],[1,0,0],n_steps),
            cubicBezier3D_list("cube", [eps, 24*px, layer*20],[eps, 48*2*px, layer*2*40],[0*px, 0, 0*layer],[400*px, -1500*px, -(300-40)*layer],[10,0,0],[0,-12.1,0],[1,0,0],n_steps)
        )
        );

        
    
    }
        translate([.5*2560*px,0,200*layer])
            polychannel(concat(    //shape---- size 0-----------------size_1---------------point_0-----------------point_1--------------------Tan_0------Tan_1---plane--n_steps
            cubicBezier3D_list("sphere", [eps, 48*3*px, layer*40],[eps, 24*px, layer*20],[0*px, 0, 0*layer],[.5*2560*px, .5*1600*px, 0*layer],[0,10,0],[10,0,0],[1,0,0],n_steps),
            cubicBezier3D_list("sphere", [eps, 48*3*px, layer*40],[eps, 24*px, layer*20],[0*px, 0, 0*layer],[-.5*2560*px, .5*1600*px, 0*layer],[-10,0,0],[0,10,0],[1,0,0],n_steps),
            cubicBezier3D_list("sphere", [eps, 48*3*px, layer*40],[eps, 24*px, layer*20],[0*px, 0, 0*layer],[-.5*2560*px, -.5*1600*px, 0*layer],[0,-10,0],[-10,0,0],[1,0,0],n_steps),
            cubicBezier3D_list("sphere", [eps, 48*3*px, layer*40],[eps, 24*px, layer*20],[0*px, 0, 0*layer],[.5*2560*px, -.5*1600*px, 0*layer],[10,0,0],[0,-10,0],[1,0,0],n_steps)
        )
        );
                translate([.5*2560*px,0,200*layer])
            polychannel(concat(    //shape---- size 0-----------------size_1---------------point_0-----------------point_1--------------------Tan_0------Tan_1---plane--n_steps
            cubicBezier3D_list("sphere", [eps, 48*3*px, layer*40],[eps, 24*px, layer*20],[0*px, 0, 0*layer],[.5*2560*px, .5*1600*px, 0*layer],[0,10,0],[10,0,0],[1,0,0],n_steps),
            cubicBezier3D_list("sphere", [eps, 48*3*px, layer*40],[eps, 24*px, layer*20],[0*px, 0, 0*layer],[-.5*2560*px, .5*1600*px, 0*layer],[-10,0,0],[0,10,0],[1,0,0],n_steps),
            cubicBezier3D_list("sphere", [eps, 48*3*px, layer*40],[eps, 24*px, layer*20],[0*px, 0, 0*layer],[-.5*2560*px, -.5*1600*px, 0*layer],[0,-10,0],[-10,0,0],[1,0,0],n_steps),
            cubicBezier3D_list("sphere", [eps, 48*3*px, layer*40],[eps, 24*px, layer*20],[0*px, 0, 0*layer],[.5*2560*px, -.5*1600*px, 0*layer],[10,0,0],[0,-10,0],[1,0,0],n_steps)
        )
        );
}
$fn=40;

translate([.5*2560*px,150*px,200*layer])
rotate([90,90,0])
cylinder([600*px,150*px]);
translate([.5*2560*px,(1600-150)*px,200*layer])
rotate([90,90,0])
cylinder([600*px,150*px]);
translate([0,800*px,200*layer])
rotate([90,0,90])
cylinder([600*px,150*px]);
translate([2560*px-131*px,800*px,200*layer])
rotate([90,0,90])
cylinder([600*px,150*px]);
