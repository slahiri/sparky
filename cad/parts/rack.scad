// Rack: the body everything slides into. Floor, two side walls (a LiPo can
// slide in along either one), rails for the board, a fixed middle plate with
// grooves for the MPU-6050 and the amp, and a fixed top with the mic and
// touch pad, between two towers that carry the shell magnets. The plate and
// the top stop 6 mm short of the back: that gap is the wire channel.
// The back is open: the board, the two sensor boards and a LiPo slide in from
// there; the face frame drops in at the front.
// Prints upright on its floor without supports. The plate (55 mm) and the
// top (40 mm) are bridges between the walls.
include <../config.scad>

module tower(s) {   // s = -1 left, +1 right
  mirror([s < 0 ? 1 : 0, 0, 0]) {
    translate([tower_x, face_yb, tower_z0]) cube([rack_xo - tower_x, rack_yb - face_yb, lid_top - tower_z0]);
    // 45 deg gusset from the wall up to the tower's inner face
    along_y(face_yb, rack_yb)
      polygon([[rack_xi + 0.01, tower_z0 - (rack_xi - tower_x)], [rack_xi + 0.01, tower_z0 + 0.01], [tower_x, tower_z0 + 0.01]]);
  }
}

// Middle plate: fixed. Two grooves on top (a rail each side with a lip over
// the board edge, and a front stop); the boards slide in from the back.
module plate() {
  translate([-rack_xi - 0.01, plate_y0, plate_z0]) cube([2*rack_xi + 0.02, deck_y1 - plate_y0, plate_t]);
  for (g = [[mpu_cx, mpu], [amp_cx, amp]]) {
    cx = g[0]; b = g[1]; w = b[0]/2 + 0.2;
    for (s = [-1, 1]) {
      translate([s < 0 ? cx - w - 1.25 : cx + w, groove_y0 - 1, plate_z1 - 0.01]) cube([1.25, deck_y1 - groove_y0 + 1, b[2] + 1.01]);   // rail
      translate([s < 0 ? cx - w - 0.01 : b[0]/2 - 0.55 + cx, groove_y0 + 1, plate_z1 + b[2] + 0.3])
        cube([w + 0.01 - (b[0]/2 - 0.55), b[1] - 5, 0.7]);                                                                     // lip
    }
    translate([cx - w - 1.25, groove_y0 - 1, plate_z1 - 0.01]) cube([2*w + 2.5, 1, 1.5]);                                     // front stop
  }
}

// Top: fixed, between the towers. The round INMP441 mic sits in a pocket at
// the front (sound port up, under the shell's pinhole) and the TTP223 touch
// pad lies on top at the back, against the shell ceiling. Both sit over
// openings, so their pins and wires come straight up from below.
module top() {
  difference() {
    translate([-tower_x - 0.01, face_yb, rack_top]) cube([2*tower_x + 0.02, deck_y1 - face_yb, lid_t]);
    translate([mic_xy[0], mic_xy[1], lid_top - 2.2]) cylinder(d = mic_d + 0.4, h = 3, $fn = 64);
    // open underneath: the mic rests on a 1.2 mm rim, the touch pad on a 1 mm edge
    translate([mic_xy[0], mic_xy[1], rack_top - 1]) cylinder(d = mic_d - 2, h = lid_t + 2, $fn = 64);
    translate([-touch[0]/2 + 1, touch_y0 + 1, rack_top - 1]) cube([touch[0] - 2, touch[1] - 2, lid_t + 2]);
    translate([mic_xy[0] - 8.1, mic_xy[1] + 3.2, rack_top - 1]) cube([16.2, 3, lid_t + 2]);
    translate([-5.6, touch_y0 + touch[1] - 1.6, rack_top - 1]) cube([8.2, 3.1, lid_t + 2]);
  }
}

module rack_body() {
  intersection() {
    union() {
      // floor
      translate([-rack_xo, rack_yf, floor_z]) cube([2*rack_xo, rack_yb - rack_yf, floor_t]);
      for (s = [-1, 1]) {
        // side wall
        translate([s < 0 ? -rack_xo : rack_xi, face_yb, in_z - 0.01]) cube([rack_t, rack_yb - face_yb, lid_top - in_z + 0.01]);
        tower(s);
        mirror([s < 0 ? 1 : 0, 0, 0]) {
          // board guide rail and the ledge the board edge rests on
          translate([board[0]/2 + 0.2, board_y0 - 0.2, in_z - 0.01]) cube([2.4, rack_yb - board_y0 + 0.2, 3.2]);
          translate([board[0]/2 - 1, board_y0 - 0.2, in_z - 0.01]) cube([1.21, rack_yb - board_y0 + 0.2, board_z - in_z + 0.01]);
          // board front stop
          translate([board[0]/2 - 2, board_y0 - 1.2, in_z - 0.01]) cube([4.6, 1, 2.2]);
          // speaker stop: holds the speaker in the face frame's pocket
          translate([spk_post_x, face_yb, in_z - 0.01]) cube([4, 1.6, spk_post_h]);
        }
      }
      plate();
      top();
    }
    // rounded plan outline
    translate([0, 0, floor_z - 1]) linear_extrude(lid_top - floor_z + 2) rack_2d();
  }
}

module rack() {
  difference() {
    union() {
      rack_body();
      // solid bottom over the full footprint: Sparky stands on it, the collar sits on it
      linear_extrude(base_top) outer_2d();
    }
    // 45 deg chamfers on the towers' outer and back top edges (clear the shell's inside radius)
    for (s = [-1, 1]) translate([s*rack_xo, 0, lid_top]) rotate([0, 45, 0]) cube([chamfer*1.42, 200, chamfer*1.42], center = true);
    translate([0, rack_yb, lid_top]) rotate([45, 0, 0]) cube([200, chamfer*1.42, chamfer*1.42], center = true);
    // shell magnets in the tower tops
    for (p = mag_rack_shell) translate([p[0], p[1], 0]) mag_pocket(lid_top - mag_h + 0.01);
    // collar locating pins
    for (p = collar_pins) translate([p[0], p[1], 0]) pin_hole_at(base_top - pin_depth + 0.01);
    // face frame locating pins
    for (p = face_pins) translate([p[0], p[1], 0]) pin_hole_at(in_z - pin_depth, pin_depth + 1);
  }
}

rack();
