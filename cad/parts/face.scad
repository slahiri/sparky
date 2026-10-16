// Face frame: the front of Sparky, behind a removable front plate. Pull the
// plate off (notches on both sides) and the display and the speaker go in
// from the front; two posts on the rack floor stop the speaker from behind.
// The frame stands on the rack floor on two filament pins; the shell holds
// it in.
// Both parts print face-down: every shelf, stop and peg grows off the bed.
include <../config.scad>

module face() {
  yi  = rack_yf + face_t;             // inside of the front plate
  sx  = speaker[0]/2 + 0.2;           // speaker pocket half-width
  gy  = yi + glass[1] + oled[1] + 0.2;// display groove: glass + PCB + clearance
  difference() {
    intersection() {
      union() {
        translate([-rack_xo, rack_yf + face_t, in_z]) cube([2*rack_xo, face_yb - rack_yf - face_t, flange_t]); // bottom flange
        translate([-rack_xi, yi, ledge_z0]) cube([2*rack_xi, face_yb - yi, oled_z0 - ledge_z0]); // display shelf
        for (s = [-1, 1]) mirror([s < 0 ? 1 : 0, 0, 0]) {
          translate([rack_xi, rack_yf + face_t, in_z]) cube([rack_t, face_yb - rack_yf - face_t, rack_top - in_z]); // cheek
          translate([sx, yi, in_z]) cube([rack_xi - sx + 0.01, face_yb - yi, ledge_z0 - in_z]); // speaker side block
          translate([oled[0]/2 + 0.2, yi, oled_z0 - 0.01]) cube([rack_xi - oled[0]/2 - 0.2 + 0.01, gy + 1.2 - yi, rack_top - oled_z0 + 0.01]); // display side stop
          translate([oled[0]/2 - 3.7, gy, oled_z0 - 0.01]) cube([3.91, 1.2, rack_top - oled_z0 + 0.01]);   // display rear strip
        }
      }
      translate([0, 0, in_z - 1]) linear_extrude(rack_top - in_z + 2) rack_2d();
    }
    // holes for the front plate's pegs
    for (p = front_pegs) translate([p[0], rack_yf + face_t - 0.5, p[1]]) rotate([-90, 0, 0]) cylinder(d = peg_hole, h = peg_l + 0.9, $fn = 24);
    // locating pin holes
    for (p = face_pins) translate([p[0], p[1], 0]) pin_hole_at(in_z - 0.01);
  }
}

face();
