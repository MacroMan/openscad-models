include <../../scripts/print-resolution.scad>
use <../../scripts/transformations.scad>
use <../../modules/pin-header.scad>
use <ethernet.scad>
use <usb.scad>
use <headphone.scad>
use <hdmi.scad>
use <micro-usb.scad>
use <expansion.scad>
use <micro-sd-slot.scad>

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

union() {
    difference() {
        board();
        mountingHoles();
    }

    translate([7.1, 50, _boardHeight])
        pinHeader(2, 20); // GPIO pins
    
    translate([58.96, 43.837, _boardHeight])
        pinHeader(2, 2); // POE pins
    
    translate([58.96, 38.74, _boardHeight])
        pinHeader(1, 2); // PEN & RUN pins
    
    translate([65.75, 2.5, _boardHeight])
        ethernetPort();
    
    for(y=[22.25, 40.25])
        translate([69.85, y, _boardHeight])
            usbPorts();
    
    translate([49.925, 0, _boardHeight])
        headphone();
    
    translate([24.5, -1.65, _boardHeight])
        HDMI();

    translate([6.6, -1.5, _boardHeight])
        microUSB();

    translate([1, 18, _boardHeight])
        expansionPort();
    translate([45, 22, _boardHeight])
        rotateZ(180)
            expansionPort();

    translate([1.8, 22, -1.5])
        microSDSlot();
}
