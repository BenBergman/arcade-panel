$fn = 60;


top = true;
players = 2;


gap = 30;
width = 196;
total_width = width * players + gap * (players-1);
height = 180;
screw_radius = 4/2;
button_radius = 28/2;
stick_radius = 28/2;
corner_radius = button_radius;


translate([corner_radius, corner_radius]) {
    difference() {
        base(total_width, height, corner_radius);
        if (top) {
            for (i = [0:width + gap:total_width]) {
                translate([i, 0]) {
                    button_holes(width, height, button_radius);
                    joystick_holes(width, height, stick_radius);
                    joystick_mounting_holes(width, height, screw_radius);
                }
            }

            mounting_holes(width, height, screw_radius, players);
            exit_button(total_width / 2, height - button_radius, button_radius);
        }
    }
    //etch(total_width, height, corner_radius, width);

    /*
    #mounting_holes(width, height, screw_radius * 2, players);
    #for (i = [0:width + gap:total_width]) {
        translate([i, 0]) {
            button_holes(width, height, button_radius);
            joystick_holes(width, height, stick_radius);
            joystick_mounting_holes(width, height, screw_radius);
        }
    }
    %base(total_width, height, corner_radius);
    */
}


module etch(w_t, h_t, r, w) {
    scale = 0.9;
    outer_offset = 0.02 * h_t;
    inner_offset = 0.09 * h_t;
    difference() {
        hull() {
            translate([0 + outer_offset, 0 + outer_offset]) circle(r=r * scale);
            translate([w_t - outer_offset, 0 + outer_offset]) circle(r=r * scale);
            translate([w_t - outer_offset, h_t - outer_offset]) circle(r=r * scale);
            translate([0 + outer_offset, h_t - outer_offset]) circle(r=r * scale);
        }
        hull() {
            translate([0 + inner_offset, 0 + inner_offset]) circle(r=r * scale * scale);
            translate([w_t - inner_offset, 0 + inner_offset]) circle(r=r * scale * scale);
            translate([w_t - inner_offset, h_t - inner_offset]) circle(r=r * scale * scale);
            translate([0 + inner_offset, h_t - inner_offset]) circle(r=r * scale * scale);
        }
    }
    for (i = [0:width + gap:total_width]) {
        translate([i, 0]) {
            joystick_holes(w, h_t, 43);
        }
    }
}


module base(w, h, r) {
    hull() {
        circle(r=r);
        translate([w, 0]) circle(r=r);
        translate([w, h]) circle(r=r);
        translate([0, h]) circle(r=r);
    }
}


module mounting_holes(w, h, r, players) {
    step = (players % 2 == 1) ? w : w * players / 3 + gap * (players-1) / 3;

    for (i = [0:step:total_width + 1]) {
        translate([i, 0]) circle(r=r);
        translate([i, h]) circle(r=r);
    }
}


module button_holes(w, h, r) {
    // Minimum is the width of the widest part of the switches / 2
    shiftFromCenter = 36/2;
    translate([3/4*w, h/2]) {
        translate([-shiftFromCenter, 0]) circle(r=r);
        translate([shiftFromCenter, 0]) circle(r=r);
    }
}


module joystick_holes(w, h, r) {
    translate([1/4*w, h/2]) {
        circle(r=r);
    }
}


module joystick_mounting_holes(w, h, r) {
    mount_w = 50;
    mount_h = 50;

    translate([1/4*w, h/2]) {
        translate([mount_w/2, mount_h/2]) circle(r=r);
        translate([-mount_w/2, mount_h/2]) circle(r=r);
        translate([mount_w/2, -mount_h/2]) circle(r=r);
        translate([-mount_w/2, -mount_h/2]) circle(r=r);
    }
}


module exit_button(x, y, r) {
    translate([x, y]) circle(r=r);
}
