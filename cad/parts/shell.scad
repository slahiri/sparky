// Outer shell: 2 mm wall, R8 outside, R6 inside (so the wall stays 2 mm at
// the corners). Display window and speaker grille at the front, USB-C at
// the back, mic pinhole on top, 4 ceiling magnet bosses.
// Prints upside down on its top; the display window top is a 31 mm bridge.
include <../config.scad>

module shell() {
  in_x  = outer_w/2 - wall;
  in_y0 = outer_y0 + wall;
  in_y1 = outer_y1 - wall;
  ceil  = shell_z1 - wall;
  difference() {
    intersection() {
      translate([0, outer_cy, shell_z0 - corner_r]) rbox(outer_w, outer_d, shell_z1 - shell_z0 + corner_r + 0.2, corner_r);
      translate([-50, -50, shell_z0]) cube([100, 100, shell_z1 - shell_z0]);   // flat top and bottom
    }
    // hollow inside
    translate([0, (in_y0 + in_y1)/2, shell_z0 - 10]) rbox(2*in_x, in_y1 - in_y0, ceil - shell_z0 + 10, in_r);
    // display window
    translate([-win_w/2, outer_y0 - 1, win_z[0]]) cube([win_w, wall + 2.5, win_z[1] - win_z[0]]);
    // speaker grille
    for (i = [0 : 6]) translate([-16.2 + i*5.4, outer_y0 - 1, grille_z[0]]) cube([2.2, wall + 2.5, grille_z[1] - grille_z[0]]);
    // USB-C
    translate([-usb[0]/2, in_y1 - 0.5, usb[1]]) cube([usb[0], wall + 1.5, usb[2] - usb[1]]);
    // mic pinhole
    translate([mic_xy[0], mic_xy[1], ceil - 1]) cylinder(d = mic_hole, h = wall + 2, $fn = 16);
  }
  // ceiling magnet bosses (mate with the rack towers)
  for (p = mag_rack_shell) translate([p[0], p[1], 0])
    difference() {
      translate([0, 0, lid_top + 0.2]) cylinder(d = boss_d, h = ceil - lid_top - 0.2 + 0.5);
      mag_pocket(lid_top + 0.2 - 0.01);
    }
}

shell();
