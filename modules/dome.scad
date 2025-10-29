/* [Hidden] */
_epsilon = 0.001;

module dome(d, h, wall_thickness) {
    wall_difference = wall_thickness * 2;

    difference() {
        resize([0, 0, h])
            sphere(d = d);
        resize([0, 0, h - wall_difference])
            sphere(d = d - wall_difference);
        translate([-d/2 + _epsilon, -d/2 + _epsilon, -d])
            cube([d + (_epsilon * 2), d + (_epsilon * 2), d]);
    }
}

module internal_dome(d, h, wall_thickness) {
    wall_difference = wall_thickness * 2;

    difference() {
        resize([0, 0, h + wall_difference])
            sphere(d = d + wall_difference);
        resize([0, 0, h])
            sphere(d = d);
        translate([-(d + wall_difference) / 2 + _epsilon, -(d + wall_difference) / 2 + _epsilon, -d])
            cube([d + wall_difference + (_epsilon * 2), d + wall_difference + (_epsilon * 2), d]);
    }
}
