// Battery base: bay for a 1S LiPo, collar pin holes, 8 magnet pockets.
// Print deck-down: the deck then needs no bridge.
include <../config.scad>

module base() {
  bay_top = base_h - deck_t;    // 10, underside of the deck
  difference() {
    union() {
      difference() {
        hull() {
          translate([0, 0, 1]) rrect(outer_w, outer_d, corner_r, base_h - 1);
          rrect(outer_w - 2, outer_d - 2, corner_r - 1, 1);
        }
        translate([0, 0, -1]) rrect(outer_w - 4, outer_d - 4, corner_r - 2, bay_top + 1);
      }
      // magnet bosses under the deck (rack magnets)
      for (p = mag_base_rack) translate([p[0], p[1], bay_top - 4]) cylinder(d = boss_d, h = 4.01);
      // corner posts for the lid magnets
      for (p = mag_lid) translate([p[0], p[1], lid_t]) cylinder(d = 8, h = bay_top - lid_t + 0.01);
      // battery guide rails
      for (s = [-1, 1]) translate([s > 0 ? battery[0]/2 + 1 : -battery[0]/2 - 3, -battery[1]/2, lid_t])
        cube([2, battery[1], bay_top - lid_t + 0.01]);
    }
    // battery lead slot up to the rack
    translate([8.5, 14, bay_top - 1]) cube([4.5, 6, deck_t + 2]);
    for (p = mag_base_rack) translate([p[0], p[1], 0]) mag_pocket(base_h - mag_h + 0.01);
    for (p = mag_lid) translate([p[0], p[1], 0]) mag_pocket(lid_t - 0.01);
    // locating pin holes for the collar
    for (p = collar_pins) translate([p[0], p[1], base_h - pin_depth]) cylinder(d = pin_hole, h = pin_depth + 1, $fn = 16);
  }
}

base();
