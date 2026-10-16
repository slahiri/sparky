// Rack: the body everything slides into. Floor, two side walls with a LiPo
// bay inside each, ledges for the middle plate, rails for the board, and two
// top towers that carry the shell magnets. The back is open: the board and
// the middle plate slide in from there, the face frame drops in at the front
// and the lid drops in between the towers.
// Prints upright on its floor without supports (all overhangs are 45 deg).
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
          // LiPo bay rib
          translate([s < 0 ? -rib_x - rib_t : rib_x, face_yb, in_z - 0.01]) cube([rib_t, rack_yb - face_yb, bay_z1 - in_z]);
          mirror([s < 0 ? 1 : 0, 0, 0]) {
            // plate ledges: below (45 deg) and above
            along_y(face_yb, rack_yb)
              polygon([[rack_xi + 0.01, plate_z0], [rack_xi - ledge, plate_z0], [rack_xi + 0.01, plate_z0 - ledge - 0.01]]);
            translate([rack_xi - ledge, face_yb, plate_z1]) cube([ledge + 0.01, rack_yb - face_yb, ledge]);
            // board guide rail and the ledge the board edge rests on
            translate([board[0]/2 + 0.2, board_y0 - 0.2, in_z - 0.01]) cube([2.4, rack_yb - board_y0 + 0.2, 3.2]);
            translate([board[0]/2 - 1, board_y0 - 0.2, in_z - 0.01]) cube([1.21, rack_yb - board_y0 + 0.2, board_z - in_z + 0.01]);
            // board front stop
            translate([board[0]/2 - 2, board_y0 - 1.2, in_z - 0.01]) cube([4.6, 1, 2.2]);
          }
        }
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
