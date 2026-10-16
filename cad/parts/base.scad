// Base: a simple 5 mm plate on four feet. Magnets on top hold the rack,
// 2 filament pins locate the collar. A battery module can snap under it later.
// Prints upside down (top on the bed), so the plate never hangs between the feet.
include <../config.scad>

module base() {
  difference() {
    union() {
      translate([0, 0, feet_h]) linear_extrude(base_top - feet_h) outer_2d();
      for (x = [-1, 1], y = [-1, 1])
        translate([x*(outer_w/2 - 7), outer_cy + y*(outer_d/2 - 7), 0]) cylinder(d = 8, h = feet_h + 0.01);
    }
    for (p = mag_base_rack) translate([p[0], p[1], 0]) mag_pocket(base_top - mag_h + 0.01);
    for (p = collar_pins) translate([p[0], p[1], 0]) pin_hole_at(base_top - pin_depth + 0.01);
  }
}

base();
