$fn = 60;


difference() {
    translate([0, 0, 0]) cube([50, 105, 5]);
    translate([10, 10, -0.000001]) board();
}

translate([60, 0, 0]) difference() {
    union() {
        translate([0, 0, 3]) rotate([-90, 0, 0]) cylinder(h=10, d=20);
        translate([-10, 0, 0]) cube([30, 10, 5]);
    }
    translate([-50, -50, -30]) cube([100, 100, 30]);
    translate([0, 5, 5]) rotate([180, 0, 0]) overmold();
}



module overmold() {
    inner_lip_width = 10;
    inner_lip_height = 10;
    inner_lip_depth = 2;

    notch_width = 6.5;
    notch_height = 6.5;
    notch_depth = 1.5;

    strain_relief_diameter = 10;
    strain_relief_length = 10;

    cable_diameter = 5;

    translate([-inner_lip_width/2, 0, -inner_lip_height/2]) cube([inner_lip_width, inner_lip_depth, inner_lip_height]);
    translate([-notch_width/2, inner_lip_depth, -notch_height/2]) cube([notch_width, notch_depth, notch_height]);
    translate([0, inner_lip_depth+notch_depth, 0]) rotate([-90, 0, 0]) cylinder(h=strain_relief_length, d=strain_relief_diameter);
    translate([0, -15, 0]) rotate([-90, 0, 0]) cylinder(h=40, d=cable_diameter);

    // dropout
    {
        translate([-inner_lip_width/2, 0, 0]) cube([inner_lip_width, inner_lip_depth, inner_lip_height]);
        translate([-notch_width/2, inner_lip_depth, 0]) cube([notch_width, notch_depth, notch_height]);
        translate([-strain_relief_diameter/2, inner_lip_depth+notch_depth, 0]) cube([strain_relief_diameter, strain_relief_length, strain_relief_diameter]);
        translate([-cable_diameter/2, -15, 0]) cube([cable_diameter, 40, cable_diameter]);
    }
}


module board() {
    radius = 1;

    board_width = 35;
    board_length = 85;
    board_depth = 3;

    cube([board_width, board_length, board_depth]);
    hull() {
        translate([radius, 9, 0]) cylinder(h=20, r=radius);
        translate([4, radius, 0]) cylinder(h=20, r=radius);
        translate([board_width-radius, 9, 0]) cylinder(h=20, r=radius);
        translate([board_width-4, radius, 0]) cylinder(h=20, r=radius);
        translate([radius, board_length-3, 0]) cylinder(h=20, r=radius);
        translate([board_width-radius, board_length-3, 0]) cylinder(h=20, r=radius);
    }
}
