// Battery lid: held by 4 magnets, finger notch at the front.
include <../config.scad>

module lid() {
  difference() {
    rrect(outer_w - 4 - 2*clear, outer_d - 4 - 2*clear, corner_r - 2 - clear, lid_t);
    for (p = mag_lid) translate([p[0], p[1], 0]) mag_pocket(lid_t - mag_h);
    translate([-8, -outer_d/2, -1]) cube([16, 6, lid_t + 2]);   // finger notch
  }
}

lid();
