use <../../scripts/transformations.scad>
use <colors.scad>

module microSDSlot() {
    silver() {
        cube([11.5, 12, 1.5]);
    }
    color("FireBrick") {
        translate([-4, 0.3, 0.3])
            cube([4, 11.4, 1.2]);
    }
}
