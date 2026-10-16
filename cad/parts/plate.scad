// Middle plate (slide 2): a solid plate that slides into the wall ledges.
// The MPU-6050 slides into a groove on top, the MAX98357A amp slides into a
// groove underneath (parts down, terminal at the back). Four corner holes
// pass the wires down to the board.
// Prints standing on its back edge: every rail and lip then grows straight up.
include <../config.scad>

module plate() {
  hw = plate_w/2;
  mx = mpu[0]/2 + 0.2;                 // MPU groove half-width
  ax = amp[0]/2 + 0.2;                 // amp groove half-width
  my0 = -8.6;                          // MPU front edge
  ay0 = -12.4;                         // amp front edge
  gap = 1.2;                           // air under the plate for the amp's solder joints
  ab  = plate_z0 - gap - amp[2];       // underside of the amp
  difference() {
    union() {
      translate([-hw, plate_y0, plate_z0]) cube([plate_w, rack_yb - plate_y0, plate_t]);
      for (s = [-1, 1]) mirror([s < 0 ? 1 : 0, 0, 0]) {
        // MPU groove on top: rail + lip
        translate([mx, my0 - 1, plate_z1 - 0.01]) cube([1.25, rack_yb - my0 + 1, mpu[2] + 1.01]);
        translate([mpu[0]/2 - 0.55, my0 + 1, plate_z1 + mpu[2] + 0.3]) cube([mx + 0.01 - (mpu[0]/2 - 0.55), mpu[1] - 5, 0.7]);
        // amp groove underneath: hanger + lip
        translate([ax, ay0 - 1, ab - 0.6]) cube([1.2, rack_yb - ay0 + 1, plate_z0 - ab + 0.61]);
        translate([amp[0]/2 - 0.5, ay0 + 4, ab - 0.6]) cube([ax + 0.01 - (amp[0]/2 - 0.5), rack_yb - ay0 - 4, 0.6]);
      }
      // front stops
      translate([-mx - 1.25, my0 - 1, plate_z1 - 0.01]) cube([2*mx + 2.5, 1, 1.5]);
      translate([-ax - 1.2, ay0 - 1, plate_z0 - 1.6]) cube([2*ax + 2.4, 1, 1.61]);
    }
    // wire holes
    for (s = [-1, 1], hy = [hole_yf, hole_yb])
      translate([s < 0 ? -hole_x[1] : hole_x[0], hy[0], plate_z0 - 1]) cube([hole_x[1] - hole_x[0], hy[1] - hy[0], plate_t + 2]);
  }
}

plate();
