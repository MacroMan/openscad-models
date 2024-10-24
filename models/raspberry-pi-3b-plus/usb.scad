include <../../scripts/print-resolution.scad>
use <../../scripts/transformations.scad>
use <colors.scad>

/* [Hidden] */
_epsilon = 0.001;
_width = 17.5;
_depth = 13.15;
_height = 16;

_bigPinLength = 3.3;
_pinLength = 2.35;

module bigPin() {
    translateZ(-_bigPinLength)
        cube([1.25, 0.4, _bigPinLength+_epsilon]);
}

module bigPins() {
    translateX(0.4)
        bigPin();
    translate([0.4, _depth-0.4, 0])
        bigPin();
    translateX(6.3)
        bigPin();
    translate([6.3, _depth-0.4, 0])
        bigPin();
}

module pin() {
    translateZ(-_pinLength)
        silver()
            cylinder(r=0.2, h=_pinLength+_epsilon);
}

module pins() {
    for(row=[0:3], column=[0:1]) {
        translate([column*2.3+1.2, row*2.5+2.7, 0])
            pin();
    }
}

module flange(width) {
    cube([0.4, width, 1.2]);
}

module flanges() {
    translate([_width-0.4, (_depth-11.3)/2, 1.2])
        flange(11.3);
    translate([_width-0.4, (_depth-11.3)/2, _height-0.4])
        flange(11.3);
    translate([_width-0.4, 0.4, 2.85])
        rotateX(90)
            flange(12.3);
    translate([_width-0.4, _depth+0.8, 2.85])
        rotateX(90)
            flange(12.3);
}

module insert() {
    cube([9, 11, 2]);
}

module usbPorts() {
    difference() {
        silver() {
            translateZ(2)
                cube([_width, _depth, _height-2]);
            cube([8, _depth, 2+_epsilon]);
            bigPins();
            pins();
            flanges();
        }

        silver() {
            translate([_width-9, 0.4, 2.4])
                cube([9+_epsilon, _depth-0.8, 4.9]);
            translate([_width-9, 0.4, 10.7])
                cube([9+_epsilon, _depth-0.8, 4.9]);
        }
    }

    black() {
        translate([_width-9, 0.8, 4.9])
            insert();
        translate([_width-9, 0.8, 13.2])
            insert();
    }
}
