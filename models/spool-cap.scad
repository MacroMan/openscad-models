include <../BOSL2/std.scad>
include <../scripts/common.scad>

radius = 43;
height = 5;
bolt_radius = 4.25;

difference() {
    cyl(height, radius);
    cyl(height+(_epsilon*2), bolt_radius);
}

