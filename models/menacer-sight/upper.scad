include <../../BOSL2/std.scad>
include <../../BOSL2/rounding.scad>
include <../../scripts/common.scad>

back_angle = 55;
fwd_angle = 65;
backcut_angle = 70;
soften_radius = 0.5;

tunnel_length = 80;
body_width = 18;
body_height = 75.36737;
back_corner_height = 34;
back_corner_x = tunnel_length + (back_corner_height * tan(90-back_angle));
back_top_corner_x = back_corner_x - ((body_height - back_corner_height) / tan(fwd_angle));
fwd_corner_x = -(8 * sin(90-backcut_angle));
fwd_corner_y = 8 * cos(90-backcut_angle);
fwd_top_x = (body_height - fwd_corner_y) * cos(back_angle);
echo((77.56060 - fwd_corner_y) * cos(back_angle));

triangle_corner_radius = 2;
triangle_flare = 2;

sight_cutout_height = 26.1;
sight_cutout_length = 68;
sight_cutout_depth = body_width / 4;
sight_cutout_backcut_length = sight_cutout_length - (sight_cutout_height / 2) / tan(fwd_angle);
sight_cutout_y_offset = 18;
sight_cutout_z_offset = 41.6;

sight_grip_width = 11;
sight_grip_thickness = 2;
sight_grip_angle = 45;
sight_grip_distance = 24;
sight_grip_length = sight_cutout_depth / sin(sight_grip_angle);
sight_grip_gap = 3;
sight_grip_z = sight_cutout_z_offset + (sight_cutout_height/2);
sight_grip_y = 50;

aim_thickness = 14;

module back_body() {
    main_shape = [
        [0, 0],
        [-3.43, 8.97231],
        [40.175, 77.56060],
        [53.175, 77.56060],
        [54.5, body_height],
        [89, body_height],
        [106.97327, 38.17201],
        [80, 0],
    ];

    zrot(90)
    //  linear_sweep(main_shape, height=body_width, orient=FRONT, anchor=FRONT+LEFT);
    rounded_prism(
        main_shape, height=body_width,
        joint_top=soften_radius, joint_bot=soften_radius, joint_sides=soften_radius,
        orient=FRONT, anchor=FRONT+LEFT
    );
}

module triangle_cutout(anchor_side=RIGHT) {
    triangle = round_corners(
        [
            [0, -19],
            [0, 19],
            [-25.5, 0]
        ],
        radius=triangle_corner_radius
    );

    yrot(90)
        offset_sweep(
            triangle,
            height=body_width+_epsilon,
            ends=os_circle(r=-triangle_flare),
            anchor=anchor_side
        );
}

module body_with_cutouts() {
    difference() {
        back_body();
        back(34) up(7.3) triangle_cutout();
        back(62) up(10) zflip() triangle_cutout(LEFT);
    }
}

module sight_cutout() {
    bottom_shape = [
        [0, 0],
        [0, sight_cutout_height],
        [sight_cutout_backcut_length, sight_cutout_height],
        [sight_cutout_length, sight_cutout_height / 2],
        [sight_cutout_backcut_length, 0]
    ];    

    inset_shape = offset(
        bottom_shape,
        delta=-sight_cutout_depth,
        closed=true
    );

    // Keep the left edge vertical; chamfer the other four perimeter edges.
    top_shape = [
        [0, inset_shape[0].y],
        [0, inset_shape[1].y],
        inset_shape[2],
        inset_shape[3],
        inset_shape[4]
    ];

    up(sight_cutout_z_offset) back(sight_cutout_y_offset) zrot(90) 
        rounded_prism(
            bottom_shape, top_shape, height=sight_cutout_depth, 
            joint_top=soften_radius, joint_bot=-soften_radius, joint_sides=soften_radius, 
            orient=BACK, anchor="bot_corner1"
        );
}

module sight_grips() {
    back(sight_grip_y) up(sight_grip_z) ycopies(sight_grip_distance+sight_grip_width) zflip_copy(sight_cutout_depth+(sight_grip_gap/2)) xflip_copy((body_width/2)-sight_cutout_depth) yrot(sight_grip_angle) 
    union() {
        cuboid(
            [sight_grip_length, sight_grip_width, sight_grip_thickness], 
            rounding=sight_grip_thickness/2,
            edges=[TOP+RIGHT, BOTTOM+RIGHT, TOP+FRONT, BOTTOM+FRONT, TOP+BACK, BOTTOM+BACK, FRONT+RIGHT, BACK+RIGHT],
            anchor=LEFT+BOTTOM+FRONT,
            $fn=fn
        );
        right(_epsilon) cuboid(
            [sight_grip_thickness, sight_grip_width, sight_grip_thickness], 
            rounding=sight_grip_thickness/2,
            edges=[TOP+FRONT, BOTTOM+FRONT, TOP+BACK, BOTTOM+BACK],
            anchor=RIGHT+BOTTOM+FRONT,
            $fn=fn
        );
    }
}

module aim() {
    aim_shape = [
        [0, 0],
        [-9.44607, 24.67258],
        [-73.03085, 24.67258],
        [-73.03085, 35.95148],
        [-57.24039, 35.95148],
        [-50.33207, 45.11558],
        [-23.54469, 45.11558],
        [-20.30201, 40.18106],
        [18.46919, 40.18106]
    ];

    zrot(90) rounded_prism(
        aim_shape, height=aim_thickness, 
        joint_top=soften_radius, joint_bot=soften_radius, joint_sides=soften_radius, 
        orient=FRONT, anchor="edge0"
    );
}

// right_half(s=200, x=3) 
union() {
    difference() {
        body_with_cutouts();
        xflip_copy(body_width/2+_epsilon) sight_cutout();
    }
    sight_grips();
    aim();
}



