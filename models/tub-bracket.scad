include <../scripts/common.scad>
use <../scripts/transformations.scad>

mirror([1,0,0]) {
cube([3, 60, 40]);
cube([13, 60, 3]);
translateZ(37) {
    difference() {
        cube([16, 60, 3]);
        translate([9.5, 6.5, -_epsilon])
            cylinder(h=4, d=4);
        translate([9.5, 50.5, -_epsilon])
            cylinder(h=4, d=4);
    }
}

translateY(57)
    cube([13, 3, 40]);
}
