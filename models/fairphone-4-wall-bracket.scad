include <../BOSL2/std.scad>
include <../BOSL2/rounding.scad>
include <../BOSL2/screws.scad>
include <../scripts/common.scad>

display = "main"; // [main, mount, mount_pegs]

$slop = 0.05;
slop = get_slop();
slop2 = slop*2;

phone_width = 75.7;
phone_thickness = 11;
// Without the radiused edges
phone_core_width = 71.5;
// without the back cover, side curves are symetric only on the core
phone_core_thickness = 8.3;
phone_edge_radius = 8;
phone_corner_raduis = 10.6;
bracket_height = 80;
wall_thickness = 2;

charger_cuttout_width = 50;
charger_cutout_depth = 9;
charger_cutout_offset = 0;

mount_width = 24;
mount_height = 30;
mount_thickness = 3.2;
mount_lip_depth = 1.8;
mount_lip_width = 2.2;

mount_peg_diameter = 6;
mount_peg_distance = mount_height/2;
mount_peg_offset = 1;

mount_x_offset = 30;
mount_y_offset = 14.4;
mount_z_offset = 57.58;

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
    back(3.3) difference() {
        base();
        up(bracket_height) left(phone_edge_radius+_epsilon) fwd(phone_edge_radius+_epsilon) cube([phone_width*2, phone_edge_radius*(2+_epsilon*2), bracket_height*2]);
        fwd(phone_core_thickness / 2 + phone_core_thickness - _epsilon) left(phone_width/2) down(bracket_height/2) cube([phone_width*2, phone_core_thickness, bracket_height*2]);
        fwd(phone_core_thickness / 2 - phone_thickness + _epsilon) left(phone_width/2) down(bracket_height/2) cube([phone_width*2, phone_thickness, bracket_height*2]);
    }
}

module charger_cutout() {
    back(charger_cutout_offset) down(phone_corner_raduis+(wall_thickness*2)) right((phone_width/2)-(charger_cuttout_width/2)-phone_edge_radius)
        cube([charger_cuttout_width, charger_cutout_depth, wall_thickness*6]);
}

module mount_pegs(_slop=0) {
    zcopies(mount_peg_distance) fwd(wall_thickness) ycyl(l=mount_thickness+(wall_thickness*2)+_epsilon-mount_peg_offset-_slop, d=mount_peg_diameter-(_slop*2), center=true);
}

module mount() {
    difference() {
        union() {
            cube([mount_width-slop2, mount_thickness+slop2, mount_height-slop], center = true);
            back(((mount_thickness+slop2)/2)-((mount_lip_depth-slop2)/2)) 
                cube([mount_width+(mount_lip_width*2)-slop2, mount_lip_depth-slop2, mount_height-slop], center = true);
        }

        mount_pegs();
    }
}

module main() {
    difference() {
        move([-wall_thickness+0.5, wall_thickness-1, -wall_thickness]) resize([phone_width+(wall_thickness*2), phone_thickness+wall_thickness, bracket_height+wall_thickness]) core();
        core();
        back(3.5) fwd(0.9) up(7) right(56) cube([5, 15, 15], center=true);
        charger_cutout();
        move([mount_x_offset, mount_y_offset-_epsilon, mount_z_offset]) mount_pegs();
    }
}

if (display == "main") {
    main();
} else if (display == "mount") {
    move([mount_x_offset, mount_y_offset-_epsilon, mount_z_offset]) mount();
} else if (display == "mount_pegs") {
    mount_pegs(get_slop());   
}
