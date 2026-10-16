// Front plate: the 2 mm face with the display window and the speaker grille.
// It presses onto the face frame with 4 round pegs; a notch on each side edge
// lets you lever it off with a fingernail to reach the display and speaker.
// Prints face-down, pegs up.
include <../config.scad>

module front() {
  yi = rack_yf + face_t;
  difference() {
    union() {
      intersection() {
        translate([-rack_xo, rack_yf, in_z]) cube([2*rack_xo, face_t, rack_top - in_z]);
        translate([0, 0, in_z - 1]) linear_extrude(rack_top - in_z + 2) rack_2d();
      }
      // pegs with a chamfered tip
      for (p = front_pegs) translate([p[0], yi - 0.01, p[1]]) rotate([-90, 0, 0]) {
        cylinder(d = peg_d, h = peg_l - 0.5, $fn = 24);
        translate([0, 0, peg_l - 0.51]) cylinder(d1 = peg_d, d2 = peg_d - 0.8, h = 0.5, $fn = 24);
      }
    }
    // display window (the glass sits against the plate)
    translate([-glass[0]/2 - 0.2, rack_yf - 1, oled_z0 + glass_up - 0.2]) cube([glass[0] + 0.4, face_t + 2, glass[2] + 0.4]);
    // speaker grille
    for (i = [0 : 6]) translate([-17 + i*5.4, rack_yf - 1, grille_z[0] - 0.4]) cube([2.4, face_t + 2, grille_z[1] - grille_z[0]]);
    // pull notches on both side edges, cut into the back face
    // (the plate's side edges are the 45 deg corner chamfers, so the notch runs out through them)
    for (s = [-1, 1]) translate([s < 0 ? -rack_xo - 1 : rack_xo - rack_cf - notch[1], yi - notch[0], (in_z + rack_top)/2 - notch[2]/2])
      cube([notch[1] + rack_cf + 1, notch[0] + 0.01, notch[2]]);
  }
}

front();
