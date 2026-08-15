include <../../BOSL2/std.scad>
include <../../scripts/common.scad>

body_dia = 56;
body_thickness = 5;
body_extension = 21.36;
body_length = 74;
body_backcut = 5;
backcut_angle = 20;
back_angle = 55;
back_cover_thickness = 3;

rail_thickness = 4.5;
rail_gap = 40.5;
rail_offset = 2.5;

notch_offset = 17;
notch_length = 11;
notch_depth = 1.5;

body_total_length = body_length + body_extension + body_backcut + back_cover_thickness;

module body_rails() {
    up(rail_offset + (rail_thickness/2)) {
        difference() {
            cube([body_dia, body_total_length, rail_thickness], center=true);
            cube([rail_gap, body_total_length+_epsilon, rail_thickness+_epsilon], center=true);
        }
    }
}

module body_tunnel(full_diff = false) {
    difference() {
        ycyl(d=body_dia+(body_thickness*2), h=body_total_length);
        if (full_diff) {
            ycyl(d=body_dia, h=body_total_length+_epsilon);
        }
        down((body_dia / 2) - rail_offset)
            cube([body_dia + (body_thickness*2), body_total_length+_epsilon, body_dia], center=true);
    }

    if (full_diff) {
        body_rails();
    }
}

module diff_cube(rot_deg) {
    left((body_dia+(body_thickness*2))/2) up(rail_offset) xrot(-rot_deg) cube([body_dia+(body_thickness*2)+_epsilon, body_dia, body_dia]);
}

module diff_backcut() {
    up(rail_offset) back((body_total_length/2)-body_backcut) xrot(-backcut_angle) cube([body_dia+(body_thickness*2)+_epsilon, body_dia, body_dia]);
}

module full_tunnel() {
    difference() {
        body_tunnel(true);
        back(body_total_length/2) diff_cube(-(90-back_angle));
        fwd((body_total_length/2)-body_extension) diff_cube(-(70+back_angle));
        left((body_dia+(body_thickness*2))/2) diff_backcut();
    }
}

module back_cover() {
    difference() {
        body_tunnel();
        back(back_cover_thickness/2) diff_cube(-(90-back_angle));
        fwd(back_cover_thickness/2) diff_cube(-(70+back_angle));
        down(_epsilon) back(back_cover_thickness/2) diff_cube(0);
    }
}

module notch() {
    down(_epsilon) left((rail_gap/2)-_epsilon) {
        back((body_total_length/2)-notch_offset-body_backcut) prismoid(size1=[rail_thickness+(_epsilon*2), notch_length], size2=[rail_thickness+(_epsilon*2), notch_length - (notch_depth*2)], h=notch_depth, orient=LEFT, anchor=BOTTOM+LEFT);
        back((body_total_length/2)-(notch_offset/2)-notch_depth) cube([notch_depth/2, notch_offset, rail_thickness+(_epsilon*2)], anchor=BOTTOM+RIGHT);
        back((body_total_length/2)-(body_backcut/6)) prismoid(size1=[rail_thickness+(_epsilon*2), notch_length], size2=[rail_thickness+(_epsilon*2), notch_length - (notch_depth*4)], h=notch_depth*2, orient=LEFT, anchor=BOTTOM+LEFT);
    }
}

module tunnel() {
    difference() {
        down(rail_offset) union() {
            full_tunnel();
            fwd((body_total_length/2)-body_extension) back_cover();
        }
        notch();
        xflip() notch();
    }
}

tunnel();
