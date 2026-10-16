// Lid: drops in between the rack's two towers. The round INMP441 mic sits
// in a pocket at the front (sound port up, under the shell's pinhole) and the
// TTP223 touch pad lies on top at the back, against the shell ceiling. Their
// pins hang down through two slots. No magnets: it stays put when you lift
// the shell, and the shell holds it down when closed.
// Prints flat, top up.
include <../config.scad>

module lid() {
  lw = 2*tower_x - 0.4;
  y0 = rack_yf + face_t;               // rests on the face frame at the front
  pocket = mic_d + 0.4;
  difference() {
    translate([-lw/2, y0, rack_top]) cube([lw, rack_yb - y0, lid_t]);
    // mic pocket (chip side down) with a relief for the mic can and a pin slot
    translate([mic_xy[0], mic_xy[1], lid_top - 2.2]) cylinder(d = pocket, h = 3, $fn = 64);
    translate([mic_xy[0], mic_xy[1], rack_top - 1]) cylinder(d = 6, h = lid_t + 2);
    translate([mic_xy[0] - 8.1, mic_xy[1] + 3.2, rack_top - 1]) cube([16.2, 3, lid_t + 2]);
    // touch pad pin slot
    translate([-5.6, 15.9, rack_top - 1]) cube([8.2, 3.1, lid_t + 2]);
    // finger notch at the back
    translate([-7, rack_yb - 2.5, lid_top - 1.5]) cube([14, 3, 2]);
  }
}

lid();
