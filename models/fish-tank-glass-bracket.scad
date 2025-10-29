include <../scripts/common.scad>

module prong_end() {
    rotate([-135, 0, 0])
        cube([4, 6, 3]);
}

module side_cut() {
    rotate([0, -118.07, 0])
            cube([4, 25, 3]);
}

difference() {
    cube([14, 22, 10]);
    translate([-1, 2, -1]) 
        cube([16, 4, 9]); // Lip over tank
    translate([-1, 8, 5])
        cube([16, 15, 9]); // Top section
    translate([2, 8, -1])
        cube([10, 15, 7]); // Gap in the middle

    translate([-1, 22, 3]) {
        prong_end();
    }
    translate([11, 22, 3]) {
        prong_end();
    }

    translate([1.6, -1, 0]) {
        side_cut();
    }

    translate([12.4, -1, 0]) {
        mirror([1, 0, 0]) {
            side_cut();
        }
    }
}




