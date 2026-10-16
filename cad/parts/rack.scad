// Inner rack: carries every component. Closed box frame, 3 mm PLA walls,
// gussets at every joint, magnet bosses top and bottom.
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
  top = crown_z + rack_t;    // 65
  difference() {
    union() {
      translate([-xo, -rack_d/2, z0]) cube([rack_w, rack_d, rack_t]);                  // floor
      for (s = [-1, 1]) translate([s < 0 ? -xo : xi, -19, z0]) cube([rack_t, yr + 19, top - z0]); // side frames
      translate([-xi, yf, z0 + rack_t]) cube([2*xi, rack_t, crown_z - z0 - rack_t]);    // front carrier
      translate([-xi, yri, z0 + rack_t]) cube([2*xi, rack_t, 6]);                       // rear lower brace
      translate([-xi, yri, 38]) cube([2*xi, rack_t, crown_z - 38]);                     // rear upper wall
      translate([8, yri, z0 + rack_t + 6]) cube([11, rack_t, 9]);                       // switch bracket
      translate([-xi, yfi, shelf_z]) cube([xi + 15.5, yri - yfi, rack_t]);              // ESP32 shelf
      translate([-xo + 0.6, -19, crown_z]) cube([rack_w - 1.2, yr + 19 - 0.6, rack_t]); // crown plate
      // speaker cradle ribs on the right frame (speaker stands on edge, fires right)
      for (y = [-12.6, 9.1]) translate([14.5, y, z0 + rack_t]) cube([xi - 14.5 + 0.01, 1.5, 33]);
      // gussets
      gusset_x(-xi, 15.5, yfi, z0 + rack_t, 4, 4);       // floor  - carrier
      gusset_x(-xi, 15.5, yfi, shelf_z, 4, -4);          // shelf  - carrier (under)
      gusset_x(-xi, xi,   yfi, crown_z, 4, -4);          // crown  - carrier
      gusset_x(-xi, xi,   yri, crown_z, -4, -4);         // crown  - rear wall
      gusset_y(yfi, yri, -xi, crown_z, 4, -4);           // crown  - left frame
      gusset_y(yfi, yri,  xi, crown_z, -4, -4);          // crown  - right frame
      gusset_y(yfi, yri, -xi, z0 + rack_t, 4, 4);        // floor  - left frame
      gusset_y(yfi, yri, -xi, shelf_z, 3, -3);           // shelf  - left frame (under)
      // magnet bosses, trimmed to the rack footprint
      intersection() {
        union() {
          for (p = mag_base_rack)  translate([p[0], p[1], z0]) cylinder(d = boss_d, h = rack_t + 4);
          for (p = mag_rack_shell) translate([p[0], p[1], crown_z - 3.5]) cylinder(d = boss_d, h = 3.51);
        }
        translate([-xo, -rack_d/2, 0]) cube([rack_w, rack_d, 100]);
      }
    }
    // side frame windows (left: two, right: one large for the speaker)
    translate([-xo - 1, -14, 18]) cube([rack_t + 2, 32, 20]);
    translate([-xo - 1, -14, 42]) cube([rack_t + 2, 32, 16]);
    translate([xi - 1,  -14, 18]) cube([rack_t + 2, 32, 40]);
    // carrier: LED hole, OLED cable slot, M2 pilot holes
    translate([0, yf - 1, led_z]) rotate([-90, 0, 0]) cylinder(d = led_d, h = rack_t + 2);
    translate([-8, yf - 1, 52]) cube([16, rack_t + 2, 5]);
    for (x = [-1, 1], z = [-1, 1])
      translate([x*oled_hole_dx/2, yf - 1, oled_hole_z + z*oled_hole_dz/2]) rotate([-90, 0, 0])
        cylinder(d = m2_pilot, h = rack_t + 2, $fn = 16);
    // wire passages: floor (battery lead), shelf, crown (mic + touch)
    translate([8.5, 14, z0 - 1]) cube([4.5, 6, rack_t + 2]);
    translate([-6, 14, shelf_z - 1]) cube([12, 4.6, rack_t + 2]);
    translate([-6, 13, crown_z - 4]) cube([12, 4, rack_t + 5]);
    // magnet pockets
    for (p = mag_base_rack)  translate([p[0], p[1], 0]) mag_pocket(z0 - 0.01);
    for (p = mag_rack_shell) translate([p[0], p[1], 0]) mag_pocket(top - mag_h + 0.01);
  }
}

rack();
