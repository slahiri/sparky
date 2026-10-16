// Rack: the body everything slides into. Floor, two side walls (a LiPo can
// slide in along either one), rails for the board, a fixed middle plate with grooves for
// the MPU-6050 and the amp, and two top towers that carry the shell magnets.
// The back is open: the board, the two sensor boards and the batteries slide
// in from there, the face frame drops in at the front and the lid drops in
// between the towers.
// Prints upright on its floor without supports. The middle plate is a 55 mm
// bridge between the walls; the back beam a 40 mm one.
include <../config.scad>

module tower(s) {   // s = -1 left, +1 right
  mirror([s < 0 ? 1 : 0, 0, 0]) {
    translate([tower_x, face_yb, tower_z0]) cube([rack_xo - tower_x, rack_yb - face_yb, lid_top - tower_z0]);
    // 45 deg gusset from the wall up to the tower's inner face
    along_y(face_yb, rack_yb)
      polygon([[rack_xi + 0.01, tower_z0 - (rack_xi - tower_x)], [rack_xi + 0.01, tower_z0 + 0.01], [tower_x, tower_z0 + 0.01]]);
    // ledge the lid rests on (45 deg underside)
    along_y(face_yb, rack_yb - 3)
      polygon([[tower_x + 0.01, rack_top], [tower_x - ledge, rack_top], [tower_x + 0.01, rack_top - ledge - 0.01]]);
  }
}

// Middle plate: fixed. Two grooves on top (a rail each side with a lip over
// the board edge, and a front stop); the boards slide in from the back.
module plate() {
  difference() {
    union() {
      translate([-rack_xi - 0.01, plate_y0, plate_z0]) cube([2*rack_xi + 0.02, rack_yb - plate_y0, plate_t]);
      for (g = [[mpu_cx, mpu], [amp_cx, amp]]) {
        cx = g[0]; b = g[1]; w = b[0]/2 + 0.2;
        for (s = [-1, 1]) {
          translate([s < 0 ? cx - w - 1.25 : cx + w, groove_y0 - 1, plate_z1 - 0.01]) cube([1.25, rack_yb - groove_y0 + 1, b[2] + 1.01]);   // rail
          translate([s < 0 ? cx - w - 0.01 : b[0]/2 - 0.55 + cx, groove_y0 + 1, plate_z1 + b[2] + 0.3])
            cube([w + 0.01 - (b[0]/2 - 0.55), b[1] - 5, 0.7]);                                                                     // lip
        }
        translate([cx - w - 1.25, groove_y0 - 1, plate_z1 - 0.01]) cube([2*w + 2.5, 1, 1.5]);                                     // front stop
      }
    }
    for (s = [-1, 1], hy = [hole_yf, hole_yb])
      translate([s < 0 ? -hole_x[1] : hole_x[0], hy[0], plate_z0 - 1]) cube([hole_x[1] - hole_x[0], hy[1] - hy[0], plate_t + 2]);
  }
}

module rack() {
  difference() {
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
          }
        }
        plate();
        // back beam between the towers (stiffens the top)
        translate([-tower_x - 0.01, rack_yb - 3, rack_top - 4]) cube([2*tower_x + 0.02, 3, 4]);
      }
      // rounded plan outline
      translate([0, 0, floor_z - 1]) linear_extrude(lid_top - floor_z + 2) rack_2d();
    }
    // 45 deg chamfers on the towers' outer and back top edges (clear the shell's inside radius)
    for (s = [-1, 1]) translate([s*rack_xo, 0, lid_top]) rotate([0, 45, 0]) cube([chamfer*1.42, 200, chamfer*1.42], center = true);
    translate([0, rack_yb, lid_top]) rotate([45, 0, 0]) cube([200, chamfer*1.42, chamfer*1.42], center = true);
    // magnets: shell (tower tops) and base (under the floor)
    for (p = mag_rack_shell) translate([p[0], p[1], 0]) mag_pocket(lid_top - mag_h + 0.01);
    for (p = mag_base_rack)  translate([p[0], p[1], 0]) mag_pocket(floor_z - 0.01);
    // face frame locating pins
    for (p = face_pins) translate([p[0], p[1], 0]) pin_hole_at(in_z - pin_depth, pin_depth + 1);
  }
}

rack();
