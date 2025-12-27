include <../BOSL2/std.scad>
include <../BOSL2/screws.scad>
include <../scripts/common.scad>
use <../modules/esp32-s2-feather.scad>
use <../modules/mcp9808.scad>

outer_diameter = 70;
outer_depth = 18;
shell_thickness = 1.5;
cover_rounding = 10;
cable_diameter = 3.5;
cable_snag_slop = 0.8;

vent_count = 8;
vent_width = 1.5;
vent_height = 4;
vent_offset = 7;

esp_y_pos = 4;
mcp_y_pos = -20;
standoff_height = 4.5;
standoff_hole_diam = 1.8;
seperator_pos = -10;

internal_cable_holes_width = 2.0;
internal_cable_holes_height = 6;
internal_cable_holes_offset = 8.0;

mounting_hole1_y_offset = 21;
mounting_hole1_x_offset = 0;

show_base = false;
show_cover = false;
show_boards = false;

module standoff(diam, height) {
  difference() {
    cylinder(d=diam + 3, h=height);
    down(_epsilon) cylinder(d=diam, h=height + (_epsilon * 2));
  }
}

module cable_snag() {
  back(5) up(standoff_height / 2) xrot(90) cube([1.5, standoff_height, 3], center=true) attach(TOP, BOTTOM)
            prismoid(size1=[1.5, standoff_height], size2=[0, standoff_height - 0.5], h=2, shift=[0, -0.5]);
}

module seperator() {
  difference() {
    cube([outer_diameter, shell_thickness, outer_depth]);
    left(outer_diameter / 2 - internal_cable_holes_offset) down(_epsilon) cube([internal_cable_holes_width, shell_thickness + (_epsilon * 2), internal_cable_holes_height]);
    right(outer_diameter / 2 - internal_cable_holes_offset) down(_epsilon) cube([internal_cable_holes_width, shell_thickness + (_epsilon * 2), internal_cable_holes_height]);
  }
}

module mounting_hole() {
  down(_epsilon) screw_hole("M2.5", head="flat", counterbore=0, length=shell_thickness + (_epsilon * 2), anchor=BOTTOM);
}

module difference_dome() {
  difference() {
    cube([outer_diameter * 2, outer_diameter * 2, outer_depth * 2], anchor=BOTTOM);
    down(_epsilon) cyl(d=outer_diameter - (shell_thickness * 2), h=outer_depth - shell_thickness, rounding2=cover_rounding, anchor=BOTTOM);
  }
}

module cover() {
  difference() {
    cyl(d=outer_diameter, h=outer_depth, rounding2=cover_rounding, anchor=BOTTOM);
    down(_epsilon) cyl(d=outer_diameter - (shell_thickness * 2), h=outer_depth - shell_thickness, rounding2=cover_rounding, anchor=BOTTOM);

    // Power cable cutout
    translate([0, -outer_diameter / 2, cable_diameter / 2 + shell_thickness]) {
      xrot(-90)
        cylinder(h=shell_thickness * 2, d=cable_diameter);
    }
    translate([-cable_diameter / 2, -outer_diameter / 2 - 1, -_epsilon])
      cube([cable_diameter, shell_thickness * 2, cable_diameter / 2 + shell_thickness]);

    // Vents
    up(vent_offset + (vent_height / 2)) xcopies(vent_width * 2, n=vent_count) cube([vent_width, outer_diameter, vent_height], center=true);
  }
}

module base() {
  difference() {
    cylinder(d=outer_diameter - (shell_thickness * 2) - $slop, h=shell_thickness) {
      attach(TOP, BOTTOM) {
        back(esp_y_pos) {
          ycopies(17.9) right(22.95) standoff(standoff_hole_diam, standoff_height);
          ycopies(19) left(22.75) standoff(standoff_hole_diam, standoff_height);
        }
        back(mcp_y_pos - 4) xcopies(15.2) standoff(standoff_hole_diam, standoff_height);
        back(seperator_pos) seperator();
        back(mcp_y_pos - 4) right(cable_diameter / 2 - cable_snag_slop) zrot(-90) cable_snag();
        back(mcp_y_pos - 4) left(cable_diameter / 2 - cable_snag_slop) zrot(90) cable_snag();
      }
    }

    back(mounting_hole1_y_offset) right(mounting_hole1_x_offset) mounting_hole();
    difference_dome();
  }
}

if (show_cover) cover();
if (show_base) base();

if (show_boards) {
  move([0, esp_y_pos, standoff_height + shell_thickness]) zrot(90) esp32S2Feather();
  move([0, mcp_y_pos, standoff_height + shell_thickness]) zrot(180) mcp9808();
}
