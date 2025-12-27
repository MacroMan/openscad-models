include <../BOSL2/std.scad>
include <../scripts/common.scad>

width = 15.8;
depth = 4;

module notch() {
  back(width) down(_epsilon) cyl(d=width * 1.5, h=depth + (_epsilon * 2), center=false);
}

difference() {
  cube([width, width * 1.5, depth]);
  left(width / 2) notch();
  right(width / 2 + width) notch();
}
