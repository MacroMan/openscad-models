include <../scripts/common.scad>
use <../scripts/transformations.scad>
use <../modules/esp32-s2-feather.scad>
use <../modules/mcp9808.scad>
use <../modules/dome.scad>

$fa = 12;
$fs = 0.4;
show_boards = false;

module standoff(majorD, minorD) {
    cone_height = (majorD - minorD) / 2;

    cylinder(d = majorD, h = 0.3);
    cylinder(d = minorD, h = 3.5 + _epsilon);
    translateZ(3.5)
        cylinder(d1 = minorD, d2 = majorD, h = cone_height);
    translateZ(3.5 + cone_height)
        cylinder(d = majorD, h = 25);
}

// Main enclosure
difference() {
    dome(80, 50, 1.5);

    // Power cable cutout
    translate([0, -40, 1.75]) {
        rotateX(-90)
        cylinder(h = 4, d = 3.5);
    }
    translate([-1.75, -40, -_epsilon])
        cube([3.5, 4, 1.75]);

    // Vents
    for (x = [-4.5:2:4.5]) {
        translate([x, -40, 6])
            cube([1, 80, 5]);
    }
}

module internals() {
    // Seperator
    difference() {
        translate([-40, -17, _epsilon])
            cube([80, 1.5, 25]);

        // USB socket hole
        translate([-5, -17 - _epsilon, 2.95])
            cube([10, 2 + (_epsilon * 2), 4.15]);

        // Wiring cutout
        translate([-16, -17 - _epsilon, -_epsilon])
            cube([2, 1.5 + (_epsilon * 2), 4]);
    }

    // esp32 standoffs
    translate([8.95, -12.4, 0]) {
        standoff(4, 2.5);
    }
    translate([-8.85, -12.4, 0]) {
        standoff(4, 2.5);
    }
    translate([9.7, 33.3, 0]) {
        standoff(4, 2.2);
    }
    translate([-9.4, 33.3, 0]) {
        standoff(4, 2.2);
    }

    // MCP9808 standoffs
    translate([-10.15, -26.5, 15]) {
        rotateX(230) {
            if (show_boards)
            mcp9808();
            translate([2.55, 10.35, 3.5]) {
                rotateX(180)
                cylinder(d = 2.55, h = 10);
            }
            translate([17.75, 10.35, 3.5]) {
                rotateX(180)
                cylinder(d = 2.55, h = 10);
            }
        }
    }

    // Wall mount tabs
    translate([20, 0, _epsilon])
        cube([20, 10, 1.5]);
    translate([-40, 0, _epsilon])
        cube([20, 10, 1.5]);
}

difference() {
    internals();
    translateZ(-_epsilon)
        internal_dome(79, 49, 40);
}

if (show_boards) {
    translate([11.5, -15, 2]) {
        rotateZ(90)
        esp32S2Feather();
    }
}




