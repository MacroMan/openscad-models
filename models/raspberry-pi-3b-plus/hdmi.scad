use <MCAD/regular_shapes.scad>
use <../../scripts/transformations.scad>
use <colors.scad>

module port() {
    difference() {
        cube([15, 12.15, 5.55]);
        for(x=[-1.4, 16.4])
            translate([x, -1, -2.6])
                rotateX(-90)
                    cylinder(r=5, h=14);
    }
}

module frontPin() {
    translateZ(-2.5)
        cube([0.5, 1, 5.6]);
}

module backPin() {
    translateZ(-2.5)
        cube([0.5, 2, 5.6]);
}

module HDMI() {
    silver() {
        translate([0, 0, 0.81]) {
            difference() {
                port();
                translate([0.5, -0.5, 0.5])
                    resize([14, 12.15, 4.55])
                        port();
            }
        }

        for(x=[0, 14.5]) {
            translate([x, 4, 0])
                frontPin();
            translate([x, 10.15, 0])
                backPin();
        }
    }
}
