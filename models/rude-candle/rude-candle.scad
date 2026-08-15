include <../../scripts/common.scad>
include <../../BOSL2/std.scad>

jar_depth = 2;
layer_depth = 1;

inner_scale = 0.94;
inner_offset = 24.9;

label_width = 60;
label_height = 75;
label_offset = 25;

inner_label_width = 40;
inner_label_height = 55;

text_offset_left = 10;
text_offset_fwd = 15;
font = "Z003";
font_size = 9;
font_spacing = 11;

lid_offset_back = 97.2;
lid_offset_right = 0.13;

module border() {
    difference() {
        cube([label_width-(layer_depth*2), label_height-(layer_depth*2), layer_depth/2], center=true);
        cube([label_width-(layer_depth*3), label_height-(layer_depth*3), (layer_depth/2)+_epsilon], center=true);
    }
}

module jar() {
    difference() {
        linear_extrude(height = jar_depth, center=true) import("jar.svg", center=true);
        fwd(inner_offset) scale([inner_scale, inner_scale, 1]) down(_epsilon) linear_extrude(height = jar_depth+(_epsilon*3), center=true) import("inner.svg", center=true);
    }
}

color("white") jar();
color("indigo") fwd(inner_offset) scale([inner_scale, inner_scale, 1]) down(jar_depth/4) linear_extrude(height = jar_depth/2, center=true) import("inner.svg", center=true);
color("black") fwd(label_offset) up((layer_depth/2)-_epsilon) cube([label_width, label_height, layer_depth], center=true);
color("white") fwd(label_offset) {
    up(layer_depth+(layer_depth/4)-(_epsilon*2)) {
        border();
        left(((label_width-(layer_depth*2))/2) - (inner_label_width/2)) cube([inner_label_width, inner_label_height, layer_depth/2], center=true);
    }
}
color("indigo") left(text_offset_left) fwd(text_offset_fwd) up(layer_depth+(layer_depth/4)+(layer_depth/2)-(_epsilon*3)) linear_extrude(height = layer_depth/2, center=true) {
    text("Erotic", font=font, size=font_size, halign="center");
    fwd(font_spacing) text("Candle", font=font, size=font_size, halign="center");
    // fwd(font_spacing*2) text("Fifty Shades of Grape", font=font, size=font_size-6.2, halign="center");
};

color("darkgoldenrod") scale([1.001, 1.001, 1]) right(lid_offset_right) back(lid_offset_back) up((jar_depth/4)-_epsilon) linear_extrude(height = jar_depth*1.5, center=true) import("lid.svg", center=true);


// Erotic candle