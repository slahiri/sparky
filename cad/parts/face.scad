// Face frame: the front of Sparky. The display slides down into its groove
// from the top, the speaker stands behind the grille below it. The frame
// stands on the rack floor on two filament pins; the shell holds it in.
// Prints face-down: every shelf and stop is then a wall growing off the bed.
include <../config.scad>

module face() {
  yi  = rack_yf + face_t;             // inside of the front plate
  sx  = speaker[0]/2 + 0.2;           // speaker pocket half-width
  gy  = yi + glass[1] + oled[1] + 0.2;// display groove: glass + PCB + clearance
  sy0 = yi + speaker[1] + 0.2;        // speaker back stop
  difference() {
    intersection() {
      union() {
        translate([-rack_xo, rack_yf, in_z]) cube([2*rack_xo, face_t, rack_top - in_z]);               // front plate
        translate([-rack_xo, rack_yf, in_z]) cube([2*rack_xo, face_yb - rack_yf, flange_t]);           // bottom flange
        translate([-rack_xi, yi - 0.01, ledge_z0]) cube([2*rack_xi, face_yb - yi + 0.01, oled_z0 - ledge_z0]); // display shelf
        for (s = [-1, 1]) mirror([s < 0 ? 1 : 0, 0, 0]) {
          translate([rack_xi, rack_yf, in_z]) cube([rack_t, face_yb - rack_yf, rack_top - in_z]);       // cheek
          translate([sx, yi - 0.01, in_z]) cube([rack_xi - sx + 0.01, face_yb - yi + 0.01, ledge_z0 - in_z]); // speaker side block
          translate([oled[0]/2 + 0.2, yi - 0.01, oled_z0 - 0.01]) cube([rack_xi - oled[0]/2 - 0.2 + 0.01, gy + 1.2 - yi, rack_top - oled_z0 + 0.01]); // display side stop
          translate([oled[0]/2 - 3.7, gy, oled_z0 - 0.01]) cube([3.91, 1.2, rack_top - oled_z0 + 0.01]);   // display rear strip
        }
        // speaker back stops (bottom and top bar)
        translate([-sx - 0.01, sy0, in_z]) cube([2*sx + 0.02, face_yb - sy0, flange_t + 3.6]);
        translate([-sx - 0.01, sy0, ledge_z0 - 5.6]) cube([2*sx + 0.02, face_yb - sy0, 5.6]);
      }
      translate([0, 0, in_z - 1]) linear_extrude(rack_top - in_z + 2) rack_2d();
    }
    // display window (the glass sits against the plate)
    translate([-glass[0]/2 - 0.2, rack_yf - 1, oled_z0 + glass_up - 0.2]) cube([glass[0] + 0.4, face_t + 2, glass[2] + 0.4]);
    // speaker grille
    for (i = [0 : 6]) translate([-17 + i*5.4, rack_yf - 1, grille_z[0] - 0.4]) cube([2.4, face_t + 2, grille_z[1] - grille_z[0]]);
    // locating pin holes
    for (p = face_pins) translate([p[0], p[1], 0]) pin_hole_at(in_z - 0.01);
  }
}

face();
