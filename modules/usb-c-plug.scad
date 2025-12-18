include <../BOSL2/std.scad>

module usbCPlug() {
    recolor("#222222") cuboid([11, 16, 6], anchor=BACK, rounding=3, edges=[TOP+LEFT, TOP+RIGHT, BOTTOM+LEFT, BOTTOM+RIGHT]) {
        attach(BACK, FRONT) 
            recolor("silver") cuboid([8.3, 7.25, 2.37], anchor=FRONT, rounding=1.185, edges=[TOP+LEFT, TOP+RIGHT, BOTTOM+LEFT, BOTTOM+RIGHT]);
        attach(FRONT, BOTTOM) cylinder(d=5.8, h=5) attach(TOP, BOTTOM) cylinder(d=3, h=20);
    }
}