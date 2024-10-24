include <../../scripts/print-resolution.scad>
use <../../modules/pin-header.scad>
use <ethernet.scad>
use <usb.scad>

/* [Hidden] */
_epsilon = 0.001;
_boardHeight = 1.5;

module board() {
    translate([3, 3, 0]) {
        color("OliveDrab") {
            minkowski() {
                cube([79, 50, _boardHeight/2]);
                cylinder(r=3, h=_boardHeight/2);
            }
        }
    }
}

module mountingHole() {
    translate([0, 0, -_epsilon]) {
        cylinder(h=1.5+(_epsilon*2), r=1.375);
    }
}

module mountingHoles() {
    for(x=[3.5, 61.5], y=[3.5, 52.5])
        translate([x, y, 0])
            mountingHole();
}

module GPIO() {
    translate([7.1, 50, _boardHeight])
        pinHeader(2, 20);
}

module ethernet() {
    translate([65.75, 2.5, _boardHeight])
        ethernetPort();
}

module usb() {
    translate([69.85, 22.25, _boardHeight])
        usbPorts();
    translate([69.85, 40.25, _boardHeight])
        usbPorts();
}

module POE() {
    translate([58.96, 43.837, _boardHeight])
        pinHeader(2, 2);
}

union() {
    difference() {
        board();
        mountingHoles();
    }

    GPIO();
    ethernet();
    usb();
    POE();
}
