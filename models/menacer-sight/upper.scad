include <../../BOSL2/std.scad>
include <../../BOSL2/rounding.scad>
include <../../scripts/common.scad>

tunnel_length = 74;
body_width = 18;
body_height = 63.5;
back_angle = 55;
fwd_angle = 30;

corner_radius = 2;
flare = 2;

module back_body() {
    main_shape = [
        [0, 0],
        [tunnel_length, 0],
        [tunnel_length+23.8, 34],
        [tunnel_length+6.3, body_height],
        [36.7, body_height],
        [-4, 6.9]
    ];

    zrot(90) linear_sweep(main_shape, height=body_width, orient=FRONT, anchor=FRONT+LEFT);
}

module triangle_cutout(anchor_side=RIGHT) {
    triangle = round_corners(
        [
            [0, -19],
            [0, 19],
            [-25.5, 0]
        ],
        radius=corner_radius
    );

    yrot(90)
        offset_sweep(
            triangle,
            height=body_width+_epsilon,
            ends=os_circle(r=-flare),
            anchor=anchor_side
        );
}

difference() {
    back_body();
    back(34) up(7.3) triangle_cutout();
    back(62) up(10) zflip() triangle_cutout(LEFT);
}


