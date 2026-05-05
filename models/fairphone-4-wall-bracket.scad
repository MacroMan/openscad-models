include <../BOSL2/std.scad>
include <../BOSL2/rounding.scad>
include <../BOSL2/screws.scad>
include <../scripts/common.scad>

phone_width = 75.5;
phone_thickness = 10.8;
// Without the radiused edges
phone_core_width = 71.5;
// without the back cover, side curves are symetric only on the core
phone_core_thickness = 8.3;
phone_edge_radius = 8;
phone_corner_raduis = 10.6;
bracket_height = 60;
wall_thickness = 2;

module base() {
    path = round_corners(
    path = [[0,0,bracket_height*2], [0,0,0], [phone_width-(phone_edge_radius*2),0,0], [phone_width-(phone_edge_radius*2),0,bracket_height*2]],
    radius = phone_corner_raduis/8
    );

    path_sweep(
        circle(r = phone_edge_radius),
        path
    );

    fwd(phone_core_thickness / 2) cube([phone_core_width-(phone_edge_radius*2), phone_thickness, bracket_height+_epsilon]);
}

module core() {
    difference() {
        base();
        up(bracket_height) left(phone_edge_radius+_epsilon) fwd(phone_edge_radius+_epsilon) cube([phone_width*2, phone_edge_radius*(2+_epsilon*2), bracket_height*2]);
        fwd(phone_core_thickness / 2 + phone_core_thickness - _epsilon) left(phone_width/2) down(bracket_height/2) cube([phone_width*2, phone_core_thickness, bracket_height*2]);
        fwd(phone_core_thickness / 2 - phone_thickness + _epsilon) left(phone_width/2) down(bracket_height/2) cube([phone_width*2, phone_thickness, bracket_height*2]);
    }
}

module screw_profile() {
    back(12.6) xrot(90) screw("M3", thread="none", head="flat",length=12);
}

module upper() {
    difference() {
        move([-wall_thickness+0.5, wall_thickness-1, -wall_thickness]) resize([phone_width+(wall_thickness*2), phone_thickness+wall_thickness, bracket_height+wall_thickness]) core();
        core();
        left(20) fwd(4) down(25) cube([phone_width*2, phone_thickness*2, bracket_height]);
        right(5) up(44) screw_profile();
        right(55) up(44) screw_profile();
    }
}

module lower() {
    difference() {
        move([-wall_thickness+0.5, wall_thickness-1, -wall_thickness]) resize([phone_width+(wall_thickness*2), phone_thickness+wall_thickness, bracket_height+wall_thickness]) core();
        core();
        left(20) fwd(4) up(15) cube([phone_width*2, phone_thickness*2, bracket_height]);
        fwd(0.9) up(7) right(57) cube([5, 15, 10], center=true);
        right(5) up(5) screw_profile();
        right(55) up(5) screw_profile();
    }
}

upper();
lower();

