$fn = 128;


top = true;
players = 2;


width = 200;
height = 120;
corner_radius = 20;
screw_radius = 4/2;
button_radius = 28/2;
stick_radius = 28/2;


difference() {
    base(width * players, height, corner_radius);
    if (top) {
        for (i = [0:width:width * (players - 1)]) {
            translate([i, 0]) {
                button_holes(width, height, button_radius);
                joystick_holes(width, height, stick_radius);
                joystick_mounting_holes(width, height, screw_radius);
            }
        }

        mounting_holes(width, height, screw_radius, players);
        exit_button(width * players / 2, height - button_radius / 2, button_radius);
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
    step = (players % 2 == 1) ? w : w * players / 3;

    for (i = [0:step:w * players]) {
        translate([i, 0]) circle(r=r);
        translate([i, h]) circle(r=r);
    }
}


module button_holes(w, h, r) {
    // Minimum is the width of the widest part of the switches / 2
    shiftFromCenter = 38/2;
    translate([3/4*w, h/2]) {
        translate([-shiftFromCenter, 0]) circle(r=r);
        translate([shiftFromCenter, 0]) circle(r=r);
    }
}


module joystick_holes(w, h, r) {
    mount_w = 40;
    mount_h = 60;

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
