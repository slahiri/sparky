// Outer shell: 2 mm wall, R8 edges, all openings, 4 ceiling magnet pads.
include <../config.scad>

module shell() {
  in_w = outer_w - 2*wall;
  in_d = outer_d - 2*wall;
  difference() {
    union() {
      intersection() {
        translate([0, 0, shell_z0 - corner_r])
          rbox(outer_w, outer_d, shell_z1 - shell_z0 + corner_r, corner_r);
        translate([-50, -50, shell_z0]) cube([100, 100, 100]);
      }
    }
    // hollow inside
    translate([0, 0, shell_z0 - 10])
      rbox(in_w, in_d, shell_z1 - wall - shell_z0 + 10, corner_r - wall);
    // screen window
    translate([-screen_w/2, -outer_d/2 - 1, screen_z]) cube([screen_w, wall + 4, screen_h]);
    // status LED
    translate([0, -outer_d/2 - 1, led_z]) rotate([-90, 0, 0]) cylinder(d = led_d, h = wall + 4);
    // mic pinhole
    translate([0, mic_y, shell_z1 - wall - 1]) cylinder(d = mic_hole, h = wall + 2, $fn = 16);
    // USB-C and power switch
    translate([-usb_w/2, outer_d/2 - wall - 1, usb_z]) cube([usb_w, wall + 2, usb_h]);
    translate([sw_x - sw_w/2, outer_d/2 - wall - 1, sw_z]) cube([sw_w, wall + 2, sw_h]);
    // speaker grille on the right side
    for (i = [0 : spk_slots - 1])
      translate([outer_w/2 - wall - 1, spk_y0 + i*spk_pitch, spk_z0])
        cube([wall + 2, spk_slot_w, spk_z1 - spk_z0]);
  }
  // ceiling magnet pads (mate with the rack crown)
  for (p = mag_rack_shell) translate([p[0], p[1], 0])
    difference() {
      translate([0, 0, 65.2]) cylinder(d = boss_d, h = shell_z1 - wall - 65.2 + 0.5);
      mag_pocket(65.2 - 0.01);
    }
}

shell();
