include <../BOSL2/std.scad>
include <../scripts/common.scad>

width = 29;
length = 60.8;

catch_height = 8;
catch_width = 4.6;
cyl_plunge = 4.5;

lip_width = 3.3;
lip_depth = 1.6;

notch = true;
notch_width = 2;
notch_length = 4;
notch_depth = 4;
notch_offset = 26.5;

module catch() {
  difference() {
    cube([width, catch_width, catch_height], center=true);
    left(_epsilon) fwd(cyl_plunge) up(1.18) xcyl(d=8, h=width + (_epsilon * 3), center=true);
  }
}

cube([width, length, 2.3]) {
  attach(BOTTOM, TOP, align=BACK) cube([width, lip_width, lip_depth]);
  attach(TOP, BOTTOM, align=BACK) catch();

  if (notch) {
    fwd(notch_offset + lip_width) attach(BOTTOM, TOP, align=BACK + RIGHT) cube([notch_width, notch_length, notch_depth]);
  }
}
