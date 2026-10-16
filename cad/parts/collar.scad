// Interface collar: the separate "lip" between battery base and shell.
// Located by 4 filament pins in the base, clamped by the shell. No fasteners.
include <../config.scad>

module collar() {
  hole_w = rack_w + 2*0.2;   // rack floor passes through
  hole_d = rack_d + 2*0.2;
  difference() {
    union() {
      rrect(outer_w, outer_d, corner_r, collar_h);
      translate([0, 0, collar_h])
        rrect(outer_w - 2*wall - 2*0.2, outer_d - 2*wall - 2*0.2, corner_r - wall - 0.2, ridge_h);
    }
    translate([0, 0, -1]) rrect(hole_w, hole_d, 4, collar_h + ridge_h + 2);
    for (p = collar_pins) translate([p[0], p[1], -1]) cylinder(d = pin_hole, h = pin_depth + 1, $fn = 16);
  }
}

collar();
