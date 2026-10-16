// Sparky - shared parameters and the module interface spec.
// All dimensions in mm. Origin: centre line of the body, on the table.
// +X = right, +Y = back, -Y = front (screen side), +Z = up.
//
// Values marked (measure) are estimates; measure your parts and edit here.

$fn = 48;

// ---------- Interface (keep fixed so modules stay swappable) ----------
outer_w   = 64.4;    // shell, collar and rack-bottom footprint
outer_y0  = -30;     // front face of the shell
outer_y1  = 26.6;    // back face of the shell
outer_d   = outer_y1 - outer_y0;          // 56.6
outer_cy  = (outer_y0 + outer_y1) / 2;    // footprint centre (Y)
corner_r  = 8;       // outer corner radius of shell, collar and rack bottom
wall      = 2;       // shell wall
in_r      = corner_r - wall;              // 6, inside radius of the shell
clear     = 0.3;     // fit clearance between printed parts

base_top  = 7;       // top of the rack's solid bottom (the collar sits on it)
collar_h  = 4;
shell_z0  = base_top + collar_h;          // 11, bottom of the shell
shell_z1  = 76;      // top of the shell

// Magnets: 6 x 3 mm neodymium discs, all N faces pointing up.
mag_d     = 6.2;     // pocket diameter (magnet 6.0)
mag_h     = 3.2;     // pocket depth (magnet 3.0)
boss_d    = 9;

mag_rack_shell = [[-23,-15],[23,-15],[-23,17],[23,17]];   // rack towers <-> shell ceiling
pin_hole  = 1.95;    // locating pins: short pieces of 1.75 mm filament
pin_depth = 3;
collar_pins = [[-15, 24.25], [15, 24.25]];   // rack bottom <-> collar
face_pins   = [[-24, -23.5], [24, -23.5]];   // rack floor <-> face frame

// ---------- Rack (the body every part slides into) ----------
rack_xo   = 29.8;    // outside of the side walls
rack_t    = 2.4;     // side wall thickness
rack_xi   = rack_xo - rack_t;            // 27.4
rack_yf   = -27.6;   // front of the face frame
rack_yb   = 21.6;    // back of the rack (open)
rack_cf   = 5.5;     // 45 deg front corner chamfer (clears the shell's inside radius, prints face-down)
rack_rb   = 3.5;     // back corner radius
floor_z   = base_top;                    // 7
floor_t   = 4.4;
in_z      = floor_z + floor_t;           // 11.4, top of the floor
rack_top  = 68.4;    // top of the walls = underside of the lid
lid_t     = 4;
lid_top   = rack_top + lid_t;            // 72.4

tower_x   = 19.9;    // inner face of the two top towers (the top spans between them)
tower_z0  = rack_top - 2;                // underside of the towers
chamfer   = 3;       // 45 deg chamfer on the towers' outer top edges


// Middle plate: part of the rack. The MPU-6050 and the amp slide into
// grooves on top of it from the back; only the boards move.
plate_z0  = 43;
plate_t   = 3;
plate_z1  = plate_z0 + plate_t;          // 46
plate_y0  = -15.2;
mpu_cx    = -11.5;                       // groove centres (X)
amp_cx    = 10;
groove_y0 = -8.6;                        // front edge of both boards (front stops)
back_gap  = 6;                           // the plate and the top stop this far short of the back: wire channel
deck_y1   = rack_yb - back_gap;          // 15.6, back edge of the plate and the top

// Board slide (slide 1)
board     = [28, 34.6, 1.6];             // expansion board (measure)
board_y0  = -12.6;
board_z   = in_z + 1;                    // board rests on two ledges

// Face frame (display + speaker), drops onto the floor in front of the walls
face_yb   = -19.4;   // back of the face frame = front of the side walls
face_t    = 2;       // front plate
flange_t  = 2;       // bottom flange the speaker stands on
// Removable front plate: presses onto the face frame with 4 round pegs
peg_d     = 3;       // peg diameter
peg_hole  = 3.1;     // hole in the frame: snug press fit in PLA (tune after a test print)
peg_l     = 3;
front_pegs = [[-23.5, 18], [23.5, 18], [-23, 60], [23, 60]];   // [x, z]
notch     = [1.2, 3, 8];                 // pull notch on each side edge: depth (y), width (x), height (z)

// ---------- Components (measure) ----------
oled      = [35.4, 1.4, 33.4];           // 1.3" OLED PCB, landscape, pins on top
glass     = [34.5, 1.4, 23];
glass_up  = 6;       // glass bottom above the PCB bottom
speaker   = [40, 4.8, 20];               // 2040 speaker standing on edge
spk_z0    = in_z + flange_t;             // 13.4
spk_post_x = 12;                         // speaker stop posts on the rack floor (|x| from here + 4)
spk_post_h = 16;
ledge_z0  = spk_z0 + speaker[2] + 0.2;   // 33.6, display shelf
oled_z0   = ledge_z0 + 1;                // 34.6
mpu       = [20.3, 15.6, 1.6];           // GY-521
amp       = [17.8, 19.3, 1.6];           // MAX98357A
mic_d     = 14;                          // INMP441, round
mic_xy    = [-2, -10];                    // mic centre on the top
touch     = [15, 11];                    // TTP223
touch_y0  = 0;                           // front edge of the touch pad on the top
battery   = [5, 40, 30];                 // LiPo 503040 on edge

// Shell openings
win_w     = 31;      // display window (active area 29.4 x 14.7)
win_z     = [oled_z0 + glass_up + 3, oled_z0 + glass_up + 20];
grille_z  = [15.4, 31.4];
usb       = [12.4, 21.3, 28.1];          // width, z0, z1
mic_hole  = 1.4;

// ---------- Helpers ----------
module rrect2d(w, d, r) { offset(r) square([w - 2*r, d - 2*r], center = true); }
module rrect(w, d, r, h) { linear_extrude(h) rrect2d(w, d, r); }
module rbox(w, d, h, r) {      // box with every edge rounded, z from 0 to h
  hull() for (x = [-1,1], y = [-1,1], z = [r, h - r])
    translate([x*(w/2 - r), y*(d/2 - r), z]) sphere(r);
}
module mag_pocket(z) { translate([0,0,z]) cylinder(d = mag_d, h = mag_h); }
module pin_hole_at(z, h = pin_depth) translate([0,0,z]) cylinder(d = pin_hole, h = h, $fn = 16);

// Plan outline of the rack (and the collar opening)
module rack_2d(grow = 0) {
  offset(delta = grow) hull() {
    polygon([[-rack_xo + rack_cf, rack_yf], [rack_xo - rack_cf, rack_yf], [rack_xo, rack_yf + rack_cf], [-rack_xo, rack_yf + rack_cf]]);
    for (s = [-1, 1]) translate([s*(rack_xo - rack_rb), rack_yb - rack_rb]) circle(rack_rb);
  }
}
// Outer footprint (shell, collar, rack bottom)
module outer_2d() translate([0, outer_cy]) rrect2d(outer_w, outer_d, corner_r);

// A profile in the X-Z plane, extruded along Y from y0 to y1.
module along_y(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0) children();
// A profile in the Y-Z plane, extruded along X from x0 to x1.
module along_x(x0, x1) translate([x0, 0, 0]) rotate([90, 0, 90]) linear_extrude(x1 - x0) children();
