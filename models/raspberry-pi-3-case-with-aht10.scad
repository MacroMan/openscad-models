include <../scripts/print-resolution.scad>

module board() {
    translate([3, 3, 0]) {
minkowski()
{
  cube([79, 50, 0.75]);
  cylinder(r=3,h=0.75);
}
}
}

module mountingHole() {
    translate([0, 0, -0.001]) {
        cylinder(h=1.502, r=1.25);
    }
}

module GPIO() {
    translate([7.5, 50, -0.001])
        cube([50, 5, 8.501]);
}

difference() {
    board();
    translate([3.5, 3.5, 0])
        mountingHole();
    translate([61.5, 3.5, 0])
        mountingHole();
    translate([3.5, 52.5, 0])
        mountingHole();
    translate([61.5, 52.5, 0])
        mountingHole();
}

GPIO();
