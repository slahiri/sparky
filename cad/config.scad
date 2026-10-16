// Sparky - shared parameters and the module interface spec.
// All dimensions in mm. Origin: centre of the footprint, on the table.
// +X = right, +Y = back, -Y = front (screen side), +Z = up.
//
// Values marked (measure) are estimates; measure your parts and edit here.

$fn = 48;

// ---------- Interface (keep fixed so modules stay swappable) ----------
outer_w   = 56;     // footprint width
outer_d   = 52;     // footprint depth
corner_r  = 8;      // vertical corner radius of shell, collar and base
wall      = 2;      // shell wall
clear     = 0.3;    // fit clearance between printed parts

base_h    = 12;     // battery base height (deck top)
deck_t    = 2;      // base deck thickness
collar_h  = 4;      // interface collar band
ridge_h   = 2;      // locating ridge on top of the collar
shell_z0  = base_h + collar_h;  // 16, bottom of the shell
shell_z1  = 70;     // top of the shell

// Magnets: 6 x 3 mm neodymium discs, all N faces pointing up.
mag_d     = 6.2;    // pocket diameter (magnet 6.0)
mag_h     = 3.2;    // pocket depth (magnet 3.0)
boss_d    = 9;

mag_base_rack  = [[-21,-14],[21,-14],[-21,16],[21,16]];   // base deck <-> rack floor
mag_rack_shell = [[-18,-15],[18,-15],[-18,17],[18,17]];   // rack crown <-> shell ceiling
mag_lid        = [[-21,-19],[21,-19],[-21,19],[21,19]];   // lid <-> base
collar_pins    = [[-25.9,0],[25.9,0],[0,-23.9],[0,23.9]];
pin_hole  = 1.95;   // locating pins: short pieces of 1.75 mm filament
pin_depth = 3;

// ---------- Inner rack ----------
rack_z0   = base_h;  // 12, sits on the base deck
rack_w    = 47.2;
rack_d    = 43.2;
rack_t    = 3;       // structural wall thickness (PLA: keep >= 3)
crown_z   = 62;      // crown plate bottom (top = 65)
shelf_z   = 21;      // ESP32 shelf bottom (top = 24)

// ---------- Components (measure) ----------
oled_hole_dx = 30.4;           // 1.3" OLED mounting holes, centre to centre
oled_hole_dz = 28.4;
oled_hole_z  = 45;             // centre height of the OLED
m2_pilot     = 1.8;            // pilot hole for M2 self-tapping screws

screen_w  = 34;  screen_h = 24;  screen_z = 34;   // window in the shell
led_z     = 20;  led_d    = 5.2;
mic_y     = -7;  mic_hole = 1.2;
usb_w     = 12;  usb_h    = 7;   usb_z    = 33;
sw_x      = 13.5; sw_w    = 8;   sw_h     = 4;   sw_z = 30;
spk_slots = 5;   spk_y0   = -9;  spk_pitch = 3.5; spk_slot_w = 1.6;
spk_z0    = 24;  spk_z1   = 56;

battery   = [30, 40, 5];       // LiPo 503040 (measure)
lid_t     = 4;

// ---------- Helpers ----------
module rrect2d(w, d, r) { offset(r) square([w - 2*r, d - 2*r], center = true); }
module rrect(w, d, r, h) { linear_extrude(h) rrect2d(w, d, r); }
module rbox(w, d, h, r) {      // box with every edge rounded, z from 0 to h
  hull() for (x = [-1,1], y = [-1,1], z = [r, h - r])
    translate([x*(w/2 - r), y*(d/2 - r), z]) sphere(r);
}
module mag_pocket(z) { translate([0,0,z]) cylinder(d = mag_d, h = mag_h); }
