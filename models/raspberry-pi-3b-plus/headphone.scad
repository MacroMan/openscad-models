use <MCAD/regular_shapes.scad>
use <../../scripts/transformations.scad>
use <colors.scad>

/* [Hidden] */
_epsilon = 0.001;

module body() {
    cube([6.75, 12.4, 6.2]);
    translate([3.375, 0, 3.1])
        rotateX(90)
            cylinder(r=3, h=2.6);
}

module hole() {
    translate([3.375, -2.6-_epsilon, 3.1])
        rotateX(270)
            cylinder(r=1.8, h=15+(_epsilon*2));
}

module tab() {
    silver()
        translateZ(-2.5+_epsilon)
            cube([0.4, 1, 2.5+_epsilon]);
}

module headphone() {
    black() {
        difference() {
            body();
            hole();
        }
    }
    
    for(x=[0, 6.35], y=[3.14, 11.18])
        translate([x, y, 0])
            tab();
    translate([2.875, 12.4, 0])
        rotateZ(-90)
            tab();
}


