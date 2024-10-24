use <../../scripts/transformations.scad>
use <colors.scad>

/* [Hidden] */
_epsilon = 0.001;
_width=21.25;
_depth=16;
_height=13.5;
_pinPitch = 2.675;
_pinLength = 3.9;

_greenLED = "MediumSeaGreen";
_yellowLED = "Goldenrod";

module peg() {
    translateZ(-_pinLength) 
        black()
            cylinder(r=1.75, h=_pinLength + _epsilon);
}

module bigPin() {
    translateZ(-_pinLength) 
        silver()
            cube([1.25, 0.4, _pinLength + _epsilon]);
}

module pin() {
    translateZ(-_pinLength) 
        silver()
            cylinder(r=0.25, h=_pinLength + _epsilon);
}

module ethernetPort() {
    // Main body
    difference() {
        silver()
            cube([_width, _depth, _height]);
        // Main opening
        black() {
            translate([11.25, 2, 4.13])
                cube([10.001, 12, 6.9]);
            translate([11.25, 5, 2.25])
                cube([10.001, 6.3, 2]);
            translate([11.25, 6, 1])
                cube([10.001, 4, 3.2]);
        }
        // Green LED
        color(_greenLED) {
            translate([21.1, 0.9, 0.9])
                cube([0.151, 3.33, 2.4]);
        }
        // Yellow LED
        color(_yellowLED) {
            translate([21.1, 11.77, 0.9])
                cube([0.151, 3.33, 2.4]);
        }
    }

    // Pegs
    translate([_width/2, 2.15, 0])
        peg();
    translate([_width/2, _depth-2.15, 0])
        peg();

    // Big pins
    translateX(7)
        bigPin();
    translate([7, 15.6, 0])
        bigPin();
    
    // Rear pins
    for(row=[0:1], column=[0:4]) {
        yOffset = (row == 0) ? 1.9 : 3.17;
        translate([row*_pinPitch+1, column*_pinPitch+yOffset, 0])
            pin();
    }
    
    // Mid pins
    for(pos=[[6.25, 1.88], [7.48, 4.1]]) {
        translate([pos[0], pos[1], 0])
            pin();
        translate([pos[0], _depth-pos[1], 0])
            pin();
    }

    // Front pins
    for(y=[1, 3.5]) {
        translate([14, y, 0])
            pin();
        translate([14, _depth-y, 0])    
            pin();
    }
}

