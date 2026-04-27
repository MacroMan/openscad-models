include <../../BOSL2/std.scad>
include <../../scripts/common.scad>

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

module hole() {
    down(_epsilon) cylinder(h=depth+(_epsilon*2), d=hole_size);
}

module peg() {
    cyl(h=(depth*2)+(_epsilon*2), d=hole_size, rounding2=hole_size/2);
}

difference() {
    cuboid(
        [(size-1)*hole_spacing+(skirt*2), (size-1)*hole_spacing+(skirt*2), depth], 
        rounding=skirt,
        edges=[FRONT+LEFT, FRONT+RIGHT, BACK+LEFT, BACK+RIGHT],
        anchor=FRONT+LEFT+BOTTOM
    );
    right(skirt) back(skirt) {
        for (x = [0:size-1], y = [0:size-1]) {
            if ((x != 0 || y != 0) && (x != (size-1) || y != 0)) right(x*hole_spacing) back(y*hole_spacing) hole();
        }
    }
}

up(depth+(depth/2)) back(skirt) {
    right(skirt) peg();
    right(skirt+((size-1)*hole_spacing)) peg();
}