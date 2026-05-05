include <../scripts/common.scad>
include <../BOSL2/std.scad>

dia = 130;
center_hole = 5;
arm_width = 4;
depth = 1;
hook = 3;

module arm() {
    fwd(arm_width/2) cube([dia/2, arm_width, depth])
        position(RIGHT+BOTTOM) cube([depth, arm_width, hook+depth], anchor=LEFT+BOTTOM);
}

module arms() {
    arm();
    zrot(120) arm();
    zrot(240) arm();
}

difference() {
    union() {
        cyl(d=center_hole+arm_width, height=depth, center=false);
        arms();
    }
    
    down(_epsilon) cyl(d=center_hole, height=depth+(_epsilon*2), center=false);
}
