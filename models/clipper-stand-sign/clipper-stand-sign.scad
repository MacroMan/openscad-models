include <../../scripts/common.scad>
include <../../BOSL2/std.scad>

$slop = 0;
width = 160;
height = 60;
depth = 5;
text_depth = 1;
text_width = 130;
text_height = 33;
fitting_dia = 17;
fitting_depth = 6;

border_witdh = 10;
border_inset = 5;

_fitting_dia = fitting_dia - get_slop();

module border() {
    difference() {
        cube([width-border_inset, height-border_inset, text_depth], center=true);
        cube([width-border_inset-border_witdh, height-border_inset-border_witdh, text_depth+_epsilon], center=true);
    }
}

module fitting() {
    difference() {
        ycyl(d = _fitting_dia, height = fitting_depth);
        up(depth*2) cube([_fitting_dia, fitting_depth+_epsilon, depth*3], center=true);
        down(depth*2) cube([_fitting_dia, fitting_depth+_epsilon, depth*3], center=true);
    }
}

module body() {
    cube([width, height, depth], center=true);
    fwd((height/2) + (fitting_depth/2)) fitting();
}

module text() {
    up(depth/2-_epsilon) {
        resize([text_width, text_height, 0]) linear_extrude(height = text_depth, center=true) import("rect13.svg", center=true);
        border();
    }
}

color("yellow") body();
color("black") text();
