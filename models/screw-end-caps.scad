include <../scripts/common.scad>
include <../BOSL2/std.scad>

screw_dia = 3.85;
screw_depth = 2;
wall_thickness = screw_dia / 4;
outer_dia = screw_dia + (wall_thickness * 2);

difference() {
    cyl(d = outer_dia, height = screw_depth+wall_thickness, center = false);
    up(wall_thickness) cyl(d = screw_dia, height = screw_depth+_epsilon, center = false);
}
