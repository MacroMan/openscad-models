include <../../scripts/common.scad>
include <../../BOSL2/std.scad>

tele_dia = 170;
harness_width = 40;
harness_thickness = 5;
harness_clasp_thickness = 10;
harness_clasp_width = 10;
harness_clasp_hole_dia = 4;
harness_spacing = 160;

harness_bar_mount_size = 10;
harness_bar_fillet = 4;

harness_length = harness_spacing + harness_width;

module harness_clasp() {
    diff()
    cube([harness_clasp_width+harness_thickness, harness_width, harness_clasp_thickness], anchor=TOP+RIGHT)
        tag("remove") left(harness_thickness/2) cyl(h=harness_clasp_thickness+_epsilon, d=harness_clasp_hole_dia);
}

module harness_semi_section() {
    bottom_half(s=tele_dia+(harness_thickness*2)+_epsilon)
        tube(h=harness_width, id=tele_dia, wall=harness_thickness, orient=FRONT);
    up(_epsilon) {
        left(tele_dia/2) harness_clasp();
        right(tele_dia/2) xflip() harness_clasp();
    }
}

module harness_arm_bar() {
    mount_bottom = (harness_length/2)-(harness_bar_mount_size/2);
    mount_top = (harness_length/2)+(harness_bar_mount_size/2);

    linear_extrude(height = harness_clasp_width)
        polygon(path_join([
            [
                [0, 0],
                [harness_clasp_width, 0],
                [harness_clasp_width, harness_spacing+harness_width],
                [0, harness_spacing+harness_width],
                [0, mount_top],
            ], 
            [
                [0, mount_top],
                [-harness_bar_mount_size, mount_top],
                [-harness_bar_mount_size, mount_bottom],
                [0, mount_bottom]
            ],
            [
                [0, mount_bottom],
                [0, 0],
            ]
        ]));
}

module harness_arm(anchor) {
    left(harness_clasp_width) fwd((harness_spacing/2) + (harness_width/2)) diff("remove") {
        force_tag() harness_arm_bar();

        tag("remove") {
            right(harness_clasp_thickness/2) {
                back(harness_spacing + (harness_width/2))
                    cyl(h=harness_clasp_thickness+_epsilon, d=harness_clasp_hole_dia, center=false);

                back(harness_width/2)
                    cyl(h=harness_clasp_thickness+_epsilon, d=harness_clasp_hole_dia, center=false);
            }

            // back((harness_spacing + harness_width) / 2)
        }
    }
}


module harness() {
     {
        fwd(harness_spacing/2) {
            harness_semi_section();
            zflip() harness_semi_section();
        }
        back(harness_spacing/2) {
            harness_semi_section();
            zflip() harness_semi_section();
        }

        
    }
    
    down(harness_clasp_width*2) {
        left((tele_dia/2)+harness_thickness) harness_arm(TOP+RIGHT);
        right((tele_dia/2)+harness_thickness) xflip() harness_arm(TOP+LEFT);
    }
}

harness();
// harness_arm();



