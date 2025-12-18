include <../BOSL2/std.scad>
include <../scripts/common.scad>
use <../modules/pin-header.scad>

/* [Hidden] */
_boardHeight = 1.5;

module mountingHole(d) {
  cylinder(h=_boardHeight + (_epsilon * 2), d=d);
}

module mountingHoles() {
  translate([2.55, 10.35, -_epsilon])
    mountingHole(2.55);
  translate([17.75, 10.35, -_epsilon])
    mountingHole(2.55);
}

module _mcp9808(show_pin_headers) {
  // Main board
  color("DarkBlue") {
    difference() {
      cube([20.3, 12.7, _boardHeight]);
      mountingHoles();
    }
  }

  // Pin headers
  if (show_pin_headers) {
    translate([0, 1.25, _boardHeight])
      pinHeader(1, 8);
  }
}

module mcp9808(show_pin_headers) {
  left(10.15) fwd(6.35) _mcp9808(show_pin_headers);
}
