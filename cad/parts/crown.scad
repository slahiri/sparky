// Crown: the removable top of the rack. Slides in from the back on two
// dovetail tongues, carries the mic + touch sensor and the 4 shell magnets.
// Pull the shell up, (remove the lock screw), slide the crown back: the whole
// inside of the rack is open from above for wiring.
include <../config.scad>

module crown() {
  w  = rack_w - 1.2;                 // 46
  y0 = -19;  y1 = rack_d/2;          // -19 .. 21.6
  tw = dt_top_w - 2*dt_clear;        // tongue width at the crown underside
  bw = dt_bot_w - 2*dt_clear;        // tongue width at its tip
  difference() {
    union() {
      translate([0, (y0 + y1)/2, crown_z]) rrect(w, y1 - y0, rack_corner_r, crown_t);
      // dovetail tongues (hang below the plate into the rack's grooves)
      for (s = [-1, 1]) translate([s*rail_x, 0, crown_z])
        dovetail(tw, bw, dt_depth - 0.3, dt_stop_y + 0.3, y1);
    }
    // finger notch at the back for sliding it out
    translate([-7, y1 - 2.5, crown_top - 1.5]) cube([14, 3, 2]);
    // wire slot for the mic and touch sensor
    translate([-6, 13, crown_z - 1]) cube([12, 4, crown_t + 2]);
    // shell magnets (pockets from the top)
    for (p = mag_rack_shell) translate([p[0], p[1], 0]) mag_pocket(crown_top - mag_h + 0.01);
    // lock screw clearance
    if (crown_lock) translate([0, rack_d/2 - rack_t/2, crown_z - 1]) cylinder(d = 2.4, h = crown_t + 3, $fn = 16);
  }
}

crown();
