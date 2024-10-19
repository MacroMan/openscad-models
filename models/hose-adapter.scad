include <../scripts/print-resolution.scad>
use <MCAD/regular_shapes.scad>

a_depth = 30;
a_diameter = 40;

b_depth = 20;
b_diameter = 30;

wall_thickness = 2;

a_radius = a_diameter/2+wall_thickness;
b_radius = b_diameter/2+wall_thickness;

bottom_radius = max(a_radius, b_radius);
bottom_height = a_radius>b_radius ? a_depth : b_depth;
top_radius = min(a_radius, b_radius);
top_height = a_radius>b_radius ? b_depth : a_depth;

radius_difference = bottom_radius-top_radius;

module middle() {
    difference() {
        cylinder(h=radius_difference, r1=bottom_radius, r2=top_radius);
        translate([0, 0, -0.001])
            cylinder(h=radius_difference+0.002, r1=bottom_radius-wall_thickness, r2=top_radius-wall_thickness);
    }
}

module stop_ring() {
    difference() {
        cylinder(h=1, r=top_radius);
        translate([0, 0, -0.001])
            cylinder(h=1.002, r1=top_radius-wall_thickness, r2=top_radius-wall_thickness-1);
    }
}

union() {
    cylinder_tube(bottom_height+0.001, bottom_radius, wall_thickness);
    translate([0, 0, bottom_height]) {
        middle();
    }
    translate([0, 0, bottom_height+radius_difference-0.001]) {
        stop_ring();
    }
    translate([0, 0, bottom_height+radius_difference+0.998]) {
        cylinder_tube(top_height+0.001, top_radius, wall_thickness);
    }
}
