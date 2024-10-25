use <../../scripts/transformations.scad>
use <colors.scad>

/* [Hidden] */
_epsilon = 0.001;

module expansionPort() {
    cream() {
        cube([0.7, 21, 4]);
        translateX(1.8) {
            cube([0.7, 21, 4]);
            translate([0, 3, 4])
                cube([0.7, 15, 1.5]);
                
        }
    }

    black() {
        translateX(0.7) {
            cube([1.1, 21, 4]);
        }
        translateZ(4) {
            cube([1.8, 21, 1.5]);
        }
        translate([1.8, 0, 4])
            cube([0.7, 3, 1.5]);
        translate([1.8, 18, 4])
            cube([0.7, 3, 1.5]);
    }
}
