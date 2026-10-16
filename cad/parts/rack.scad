// Inner rack: carries every component. Closed box frame, 3 mm PLA walls,
// gussets at every joint, magnet bosses underneath. The top (crown) is a
// separate part that slides in from the back on two dovetail rails.
include <../config.scad>

// Triangular gusset running along X (triangle in the Y-Z plane).
module gusset_x(x0, x1, y, z, dy, dz)
  translate([x0, y, z]) rotate([90, 0, 90]) linear_extrude(x1 - x0) polygon([[0,0],[dy,0],[0,dz]]);
// Triangular gusset running along Y (triangle in the X-Z plane).
module gusset_y(y0, y1, x, z, dx, dz)
  translate([x, y1, z]) rotate([90, 0, 0]) linear_extrude(y1 - y0) polygon([[0,0],[dx,0],[0,dz]]);

module rack() {
  z0  = rack_z0;
  xo  = rack_w/2;            // 23.6, outside of the side frames
  xi  = xo - rack_t;         // 20.6, inside of the side frames
  yf  = -19.4;               // front face of the carrier (OLED sits here)
  yfi = yf + rack_t;         // -16.4
  yr  = rack_d/2;            // 21.6, back of the rack
  yri = yr - rack_t;         // 18.6
  intersection() {
  difference() {
    union() {
      translate([-xo, -rack_d/2, z0]) cube([rack_w, rack_d, rack_t]);                  // floor
      for (s = [-1, 1]) translate([s < 0 ? -xo : xi, -19, z0]) cube([rack_t, yr + 19, crown_z - z0]); // side frames
      // rail bars on top of the side frames (carry the dovetail grooves)
      for (s = [-1, 1]) translate([s < 0 ? -xo : xo - rail_cap_w, -19, crown_z - rail_cap_h])
        cube([rail_cap_w, yr + 19, rail_cap_h]);
      translate([-xi, yf, z0 + rack_t]) cube([2*xi, rack_t, crown_z - z0 - rack_t]);    // front carrier
      translate([-xi, yri, z0 + rack_t]) cube([2*xi, rack_t, 6]);                       // rear lower brace
      translate([-xi, yri, 38]) cube([2*xi, rack_t, crown_z - 38]);                     // rear upper wall
      translate([8, yri, z0 + rack_t + 6]) cube([11, rack_t, 9]);                       // switch bracket
      translate([-xi, yfi, shelf_z]) cube([xi + 15.5, yri - yfi, rack_t]);              // ESP32 shelf
      // speaker cradle ribs on the right frame (speaker stands on edge, fires right)
      for (y = [-12.6, 9.1]) translate([14.5, y, z0 + rack_t]) cube([xi - 14.5 + 0.01, 1.5, 33]);
      // gussets
      gusset_x(-xi, 15.5, yfi, z0 + rack_t, 4, 4);       // floor  - carrier
      gusset_x(-xi, 15.5, yfi, shelf_z, 4, -4);          // shelf  - carrier (under)
      gusset_y(yfi, yri, -xi, z0 + rack_t, 4, 4);        // floor  - left frame
      gusset_y(yfi, yri, -xi, shelf_z, 3, -3);           // shelf  - left frame (under)
      gusset_x(-xo + rail_cap_w, xo - rail_cap_w, yfi, crown_z - rail_cap_h, 3, -3); // carrier top edge
      // magnet bosses under the floor, trimmed to the rack footprint
      intersection() {
        for (p = mag_base_rack) translate([p[0], p[1], z0]) cylinder(d = boss_d, h = rack_t + 4);
        translate([-xo, -rack_d/2, 0]) cube([rack_w, rack_d, 100]);
      }
    }
    // dovetail grooves, open at the back, closed at the front (crown stop)
    for (s = [-1, 1]) translate([s*rail_x, 0, crown_z + 0.01])
      dovetail(dt_top_w, dt_bot_w, dt_depth, dt_stop_y, yr + 1);
    // side frame windows (left: two, right: one large for the speaker)
    translate([-xo - 1, -14, 18]) cube([rack_t + 2, 32, 20]);
    translate([-xo - 1, -14, 42]) cube([rack_t + 2, 32, 14]);
    translate([xi - 1,  -14, 18]) cube([rack_t + 2, 32, 38]);
    // carrier: LED hole, OLED cable slot, M2 pilot holes
    translate([0, yf - 1, led_z]) rotate([-90, 0, 0]) cylinder(d = led_d, h = rack_t + 2);
    translate([-8, yf - 1, 49]) cube([16, rack_t + 2, 5]);
    for (x = [-1, 1], z = [-1, 1])
      translate([x*oled_hole_dx/2, yf - 1, oled_hole_z + z*oled_hole_dz/2]) rotate([-90, 0, 0])
        cylinder(d = m2_pilot, h = rack_t + 2, $fn = 16);
    // crown lock screw: M2 pilot down into the rear wall
    if (crown_lock) translate([0, yri + rack_t/2, crown_z - 8]) cylinder(d = m2_pilot, h = 9, $fn = 16);
    // wire passages: floor (battery lead), shelf
    translate([8.5, 14, z0 - 1]) cube([4.5, 6, rack_t + 2]);
    translate([-6, 14, shelf_z - 1]) cube([12, 4.6, rack_t + 2]);
    // magnet pockets under the floor
    for (p = mag_base_rack) translate([p[0], p[1], 0]) mag_pocket(z0 - 0.01);
  }
  // rounded corners: clears the collar opening and the shell's inner radius
  translate([0, 0, z0 - 1]) rrect(rack_w, rack_d, rack_corner_r, 100);
  }
}

rack();
