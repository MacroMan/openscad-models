include <../BOSL2/std.scad>
include <../BOSL2/rounding.scad>
include <../scripts/common.scad>

width = 75;
depth = 64;
height = 35;

global_radius = 1.1;

front_width = 33;
mount_width = 32;

rear_cutoff_x_offset = (width/2) - front_width;
rear_cutoff_y_offset = 32;

front_cutoff_width = 17;
front_cutoff_x_offset = rear_cutoff_x_offset;
front_cutoff_y_offset = -12;
front_cutoff_x_2_offset = -7.5;
front_cutoff_y_2_offset = (depth/2) - mount_width;

cutout_height = height - 6;
cutout_depth = mount_width - 3;
cutout_width = 52;
cutout_x_offset = (width/2) - (cutout_width/2);
cutout_y_offset = (depth/2) - (cutout_depth/2) + _epsilon;

tab_width = 3.2;
tab_extension = 2.5;
tab_height = 7;
tab_stickout = 8;
tab_lip = 1.3;
tab_y_spacing = 14.5;
tab_z_spacing = 15;

mount_cutout_width = 24.3;
mount_cutout_height = 30;
mount_cutout_thickness = 3.4;
mount_cutout_lip_depth = 1.8;
mount_cutout_lip_width = 2.6;

mount_cutout_x_offset = (width / 2) - (front_width / 2);
mount_cutout_y_offset = depth/2+_epsilon;
mount_cutout_z_offset = (height/2) - (mount_cutout_height/2) + _epsilon;

module body() {
    difference() {
        cube([width, depth, height], center = true);
        move([rear_cutoff_x_offset, rear_cutoff_y_offset, -(height/2+_epsilon)]) zrot(-45) cube([depth, width, height+_epsilon*2]);
        move([front_cutoff_x_offset, front_cutoff_y_offset, -(height/2+_epsilon)]) zrot(135) cube([front_cutoff_width, depth, height+_epsilon*2]);
        move([front_cutoff_x_2_offset, front_cutoff_y_2_offset, -(height/2+_epsilon)]) zrot(180) cube([depth, width, height+_epsilon*2]);
        move([front_cutoff_x_offset, front_cutoff_y_offset, -(height/2+_epsilon)]) zrot(180) cube([depth, width, height+_epsilon*2]);
        move([cutout_x_offset, cutout_y_offset, 0]) cube([cutout_width, cutout_depth, cutout_height], center = true);
    }
}

module tabs() {
    zcopies(tab_z_spacing) yflip_copy(offset=tab_y_spacing/2) difference() {
        cube([tab_stickout, tab_width+tab_extension, tab_height], center = true);
        move([tab_lip, tab_extension, -tab_lip]) cube([tab_stickout, tab_width+tab_extension, tab_height], center = true);
    }
}

module mount() {
    back(mount_cutout_thickness/2) union() {
        cube([mount_cutout_width, mount_cutout_thickness, mount_cutout_height], center = true);
        back((mount_cutout_thickness/2)-(mount_cutout_lip_depth/2)) cube([mount_cutout_width+(mount_cutout_lip_width*2), mount_cutout_lip_depth, mount_cutout_height], center = true);
    }
}

module main() {
    difference() {
        union() {
            round3d(r=global_radius) 
                body();
            back(mount_width/2) left((width/2) + (tab_stickout/2) - _epsilon) tabs();
        }
        move([mount_cutout_x_offset, -mount_cutout_y_offset, mount_cutout_z_offset]) mount();
    }
}



// bottom_half(z=11) top_half(z=4) 
// left_half(x=-36)
// top_half(z=10) front_half(y=-26)
    main();

    // mount();

