include <../BOSL2/std.scad>
include <../BOSL2/rounding.scad>
include <../scripts/common.scad>

// xcopies = 5;
// ycopies = 6;
xcopies = 1;
ycopies = 1;
bottle_height = 35;
bottle_width = 39;
bottle_depth = 23;
roundover = 2;
xspacing = bottle_width+(roundover*2);
yspacing = bottle_depth+(roundover*2);

$fn=24;
path = smooth_path(square([bottle_width, bottle_depth]), relsize=0.5, closed=true, method="corners");
path_double = smooth_path(square([(bottle_width*2)+(roundover*2), bottle_depth]), relsize=0.5, closed=true, method="corners");
path_full = smooth_path(square([
    ((bottle_width+(roundover*2))*xcopies)+(roundover*2),
    ((bottle_depth+(roundover*2))*ycopies)+(roundover*2)
]), size=roundover*2, closed=true, method="corners", splinesteps=20);

color("purple") up(bottle_height+roundover) difference() {
    zflip() offset_sweep(path_full, height=bottle_height+roundover, bottom = os_circle(r=roundover));

    up(_epsilon) right(roundover*2) back(roundover*2) zflip() {
        ycopies(yspacing, ycopies, sp=[0,0,0]) xcopies(xspacing, xcopies, sp=[0,0,0])
            offset_sweep(path, height=bottle_height, bottom = os_circle(r=roundover*-1));
        // offset_sweep(path_double, height=bottle_height, bottom = os_circle(r=roundover*-1));
    }
}
