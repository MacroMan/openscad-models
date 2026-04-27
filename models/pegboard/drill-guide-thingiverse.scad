// Imperial: 12.7 (1/2" light duty) or 25.4 (1" heavier duty). Metric: 25 (light duty) or 30 (heavier duty)
hole_spacing = 25.4;
// Imperial: 3.2 (1/8" light duty) or 6.35 (1/4" heavier duty). Metric: 5 (light duty) or 6 (heavier duty)
hole_size = 6.35;
// Number of holes in guide
size = 5;
// Guide thickness (mm)
depth = 5;
// Margin around outer holes (mm)
skirt = 12;

/* [Hidden] */
_epsilon = 0.01;
$fa = $preview ? 12 : 1;
$fs = 0.4;

module hole() {
    translate([0, 0, -_epsilon]) cylinder(h=depth+(_epsilon*2), d=hole_size);
}

module peg() {
    radius = hole_size / 2;
    peg_height = (depth*2)+(_epsilon*2);

    union() {
        cylinder(h=peg_height - radius, d=hole_size);
        translate([0, 0, peg_height - radius]) sphere(r=radius);
    }
}

module rounded_cuboid(size, radius) {
    linear_extrude(height=size[2]) {
        hull() {
            translate([radius, radius]) circle(r=radius);
            translate([size[0]-radius, radius]) circle(r=radius);
            translate([size[0]-radius, size[1]-radius]) circle(r=radius);
            translate([radius, size[1]-radius]) circle(r=radius);
        }
    }
}

difference() {
    rounded_cuboid([(size-1)*hole_spacing+(skirt*2), (size-1)*hole_spacing+(skirt*2), depth], skirt);
    translate([skirt, skirt, 0]) {
        for (x = [0:size-1], y = [0:size-1]) {
            if ((x != 0 || y != 0) && (x != (size-1) || y != 0)) {
                translate([x*hole_spacing, y*hole_spacing, 0]) hole();
            }
        }
    }
}

translate([0, skirt, depth]) {
    translate([skirt, 0, 0]) peg();
    translate([skirt+((size-1)*hole_spacing), 0, 0]) peg();
}
