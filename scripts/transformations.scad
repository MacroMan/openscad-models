module translateX(val) {
    translate([val, 0, 0])
        children();
}

module translateY(val) {
    translate([0, val, 0])
        children();
}

module translateZ(val) {
    translate([0, 0, val])
        children();
}

module rotateX(val) {
    rotate([val, 0, 0])
        children();
}

module rotateY(val) {
    rotate([0, val, 0])
        children();
}

module rotateZ(val) {
    rotate([0, 0, val])
        children();
}
