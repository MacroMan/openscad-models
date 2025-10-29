include <../scripts/common.scad>
use <../modules/pin-header.scad>

/* [Hidden] */
_epsilon = 0.001;
_boardHeight = 1.5;

module mountingHole(d) {
   cylinder(h = _boardHeight + (_epsilon * 2), d=d);
}

module mountingHoles() {
    translate([2.6, 2.55, -_epsilon])
        mountingHole(2.5);
    translate([2.6, 20.35, -_epsilon])
        mountingHole(2.5);
    translate([48.3, 1.8, -_epsilon])
        mountingHole(2.2);
    translate([48.3, 20.9, -_epsilon])
        mountingHole(2.2);
}

module esp32S2Feather(show_pin_headers) {
    // Main board
    color("DarkSlateGray") {
        difference() {
            cube([51.1, 23, _boardHeight]);
            mountingHoles();
        }
    }

    // USB socket
    color("silver") {
        translate([-1.4, 7.1, _boardHeight])
            cube([7.6, 9, 3.15]);
    }

    // Pin headers
    if (show_pin_headers) {
        translate([5.3, 0, _boardHeight])
            pinHeader(1, 16);
        translate([15.6, 20.45, _boardHeight])
            pinHeader(1, 12);
    }
}
