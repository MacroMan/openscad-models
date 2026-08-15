include <../scripts/common.scad>
include <../BOSL2/std.scad>
include <../BOSL2/screws.scad>

big_end_od = 19;
small_end_od = 15;

output_width = 50;
output_offset = output_width / 2;
length_multiplier = 4; // [4:8]
length = output_offset * length_multiplier;

shell_thickness = 5;
pipe_thickness = 1.5;
clamp_length = 30;
clamp_length_half = clamp_length / 2;
transition_length = 6;

arc_radius = (length*length + output_offset*output_offset) / (4 * abs(output_offset));
arc_angle = 2 * atan(output_offset / length);
arc_path = s_bend_path(length, output_offset);

big_end_id = big_end_od - (pipe_thickness * 2);
small_end_id = small_end_od - (pipe_thickness * 2);
shell_od = big_end_id + shell_thickness;
small_shell_od = small_end_id + shell_thickness;
pipe_scale = small_end_id / big_end_id;
shell_scale = small_shell_od / shell_od;

function s_bend_path(
    length,
    vertical_offset,
    steps = 96,
) = [
        for (step_index = [0:steps])
        let(
            normalized_position = step_index / steps,
            x_position = length * normalized_position,
            y_position = vertical_offset * (
                3 * normalized_position * normalized_position
                - 2 * normalized_position * normalized_position * normalized_position
            )
        )
        [x_position, y_position]
    ];


module pipes() {
    shape = circle(d = big_end_id);
    yflip_copy() path_sweep(shape, arc_path, scale=pipe_scale);
}

module shell() {
    shape = circle(d = shell_od);
    yflip_copy() path_sweep(shape, arc_path, scale=shell_scale);
}

module body() {
    difference() {
        shell();
        left(0.001) xscale(1.002) pipes();
    }
}

module end_clamp(od, id, rounding_end = "left") {
    left_offset = rounding_end == "left" ? clamp_length_half : -clamp_length_half;
    difference() {
        xcyl(d = od, length = clamp_length + _epsilon);
        xcyl(d = id, length = clamp_length + (_epsilon * 3));
    }
    left(left_offset) torus(od = od, id = id, $fn = 96, orient = RIGHT);
}

module external_transition(from_od, to_od, length = transition_length, direction = RIGHT) {
    from_radius = from_od / 2;
    to_radius = to_od / 2;
    steps = 24;
    profile = [
        each [
            for (i = [0:steps])
            let(
                t = i / steps,
                eased = 3 * t * t - 2 * t * t * t
            )
            [from_radius + (to_radius - from_radius) * eased, -length + length * t]
        ],
        [from_radius, 0]
    ];

    if (direction == RIGHT) {
        yrot(90) rotate_extrude($fn = 128) polygon(profile);
    } else {
        yrot(-90) rotate_extrude($fn = 128) polygon(profile);
    }
}

module main() {
    body();
    left(clamp_length_half) end_clamp(big_end_od, big_end_id);
    right(_epsilon) external_transition(big_end_od - _epsilon, shell_od, direction = RIGHT);
    ycopies(n = 2, spacing = output_width) right(length + clamp_length_half) end_clamp(small_end_od, small_end_id, "right");
    ycopies(n = 2, spacing = output_width) right(length - _epsilon) external_transition(small_end_od - _epsilon, small_shell_od, direction = LEFT);
}

main();
// pipes();
