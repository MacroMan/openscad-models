use <../../scripts/transformations.scad>
use <colors.scad>

/* [Hidden] */
_epsilon = 0.001;

module corner() {
    cube([0.601, 5+(_epsilon*2), 1.202]);
}

module sideFlange() {
    cube([0.25, 0.698, 1.1]);
}

module microUSBBody() {
    difference() {
        cube([7.4, 5, 2.35]);
        translate([0, -_epsilon, 0.85])
            rotateY(135)
                corner();
        translate([7.825, -_epsilon, 0.425])
            rotateY(225)
                corner();
    }
}

module microUSB() {
    silver() {
        translate([0.22, 0.63, 0]) {
            difference() {
                microUSBBody();
                translate([0.25, -_epsilon, 0.25])
                    resize([6.9, 4.75, 1.85])
                        microUSBBody();
            }
            translate([0.25, 0, 1])
                rotateZ(160.464)
                    sideFlange();
            translate([7.35, .11, 1])
                rotateZ(205.464)
                    sideFlange();
            // @todo Top and bottom flanges
        }
    }
}
