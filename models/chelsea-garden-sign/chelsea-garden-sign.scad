include <../../scripts/common.scad>
include <../../BOSL2/std.scad>
use <GT-Super-Text-Black.otf>

width = 300;
height = 35;
depth = 5;
text_depth = 1;
text_size = 20;
fitting_dia_top = 17;
fitting_dia_bottom = 4;
fitting_depth = 40;
body_rounding = 5;

module fitting() {
    difference() {
        ycyl(d1 = fitting_dia_bottom, d2 = fitting_dia_top, height = fitting_depth);
        up(depth*2) cube([fitting_dia_top, fitting_depth+_epsilon, depth*3], center=true);
        down(depth*2) cube([fitting_dia_top, fitting_depth+_epsilon, depth*3], center=true);
    }
}

module body() {
    cuboid([width, height, depth], rounding = body_rounding, edges = [FRONT+RIGHT, FRONT+LEFT, BACK+RIGHT, BACK+LEFT]);
    fwd((height/2) + (fitting_depth/2)) fitting();
}

color("yellow") body();
color("black") up(depth/2-_epsilon) linear_extrude(text_depth, center=true) text("Chelsea Flower Show", font="GT Super Txt Trial:style=Bl", halign="center", valign="center", size=text_size);
