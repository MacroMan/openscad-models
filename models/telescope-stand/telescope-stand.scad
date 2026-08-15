include <../scripts/common.scad>
include <../BOSL2/std.scad>

display_telescope = false;
tele_dia = 170;
tele_length = 620;
harness_width = 40;
harness_thickness = 5;
harness_clasp_thickness = 10;
harness_clasp_width = 10;
harness_clasp_hole_dia = 4;
harness_spacing = 200;
wood_thickness = 20;
base_dia = 780;
support_upright_hypot = 780;
support_upright_radius = 40;

module base_plate(anchor=TOP, spin=0, orient=UP) {
    cyl(d=base_dia, height=wood_thickness, center=false, anchor=anchor, spin=spin, orient=orient)
        children();
}

module support_upright(anchor="hypot-face", spin=0, orient=UP) {
    hypot_half_len = support_upright_hypot / 2;
    coords = [[0, -hypot_half_len], [hypot_half_len, 0], [0, hypot_half_len]];
    radii = [0, support_upright_radius, 0];
    anchors = [
        named_anchor("hypot-face", [0, 0, 0], DOWN, 0)
    ];

    attachable(
        anchor,
        spin,
        orient,
        size=[wood_thickness, support_upright_hypot, hypot_half_len],
        offset=[-wood_thickness, 0, hypot_half_len / 2],
        anchors=anchors
    ) {
        yrot(-90)
            linear_extrude(height = wood_thickness)
                polygon(round_corners(coords, radius=radii));

        children();
    }
}



module telescope() {
    color("grey")
        ycyl(l=tele_length, d=tele_dia);
}

// base_plate() {
//     left(200) attach(TOP, "hypot-face")
//         support_upright();
// }

if (display_telescope) up(wood_thickness+(support_upright_hypot/2)-support_upright_radius) telescope();

up(wood_thickness+(support_upright_hypot/2)-support_upright_radius) harness();