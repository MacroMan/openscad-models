include <../BOSL2/std.scad>
min_slop = 0.00;
slop_step = 0.05;
holes = 6;
holesize = [10,10,10];
gap = 5;
l = holes * (holesize.x + gap) + gap;
w = holesize.y + 2*gap;
h = holesize.z + 5;
// To test cylinders instead, comment out the cuboid (add "//" to the beginning) and
// remove the comment in front of the cyl in both hole() and plug().
module hole(s) {
  cuboid([holesize.x + 2*s, holesize.y + 2*s, h+0.2]) position([BACK+LEFT,BACK+RIGHT]) cylinder(h+0.2,r=1, center=true, $fn=16);
//  cyl(d=holesize.x + 2*s, h=h+0.2, $fn=48);
}
module plug() {
  cuboid([holesize.x, holesize.y, holesize.z], anchor=BOT, rounding=1, edges="Z", except=BACK);
//  cyl(d=holesize.x, h=holesize.z, anchor=BOT, $fn=48);
}
diff("holes")
cuboid([l, w, h], anchor=BOT) {
  for (i=[0:holes-1]) {
    right((i-holes/2+0.5)*(holesize.x+gap)) {
      s = min_slop + slop_step * i;
      tag("holes") {
        hole(s);
        fwd(w/2-1) xrot(90) linear_extrude(1.1) {
          text(
            text=format_fixed(s,2),
            size=0.4*holesize.x,
            halign="center",
            valign="center"
          );
        }
      }
    }
  }
}
back(holesize.y*2.5) {
  diff() {
    cuboid([holesize.x+10, holesize.y+10, 15], anchor=BOT) {
      position(TOP) plug();
      tag("remove") position(BOT) cylinder(h=15+holesize.z,d=min(holesize.x, holesize.y)*.6); // Reinforce the plug end so you can use weaker infill.
    }
    up(3) fwd((holesize.y+10)/2) {
      tag("remove") prismoid([holesize.x/2,1], [0,1], h=holesize.y-6); // Arrow
    }
  }
}
