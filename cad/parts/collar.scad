// Interface collar: the band between the base and the shell. The rack floor
// passes through it; 2 filament pins locate it on the base; the shell clamps it.
include <../config.scad>

module collar() {
  difference() {
    translate([0, 0, base_top]) linear_extrude(collar_h) outer_2d();
    translate([0, 0, base_top - 1]) linear_extrude(collar_h + 2) rack_2d(clear);
    for (p = collar_pins) translate([p[0], p[1], 0]) pin_hole_at(base_top - 1, pin_depth + 1);
  }
}

collar();
