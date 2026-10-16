// Sparky - modular ESP32-C3 desk buddy.
// Open in OpenSCAD. Choose a part with the Customizer, or from the command line:
//   openscad -D 'part="rack"' -o ../stl/sparky_rack.stl sparky.scad
// Single parts come out in their print orientation, on the bed.
include <config.scad>
use <parts/shell.scad>
use <parts/collar.scad>
use <parts/rack.scad>
use <parts/face.scad>
use <parts/front.scad>

/* [View] */
part = "assembly"; // [assembly, shell, collar, rack, face, front]
explode = 0;       // [0:5:60]
show_electronics = true;
show_battery = true;

// ---------- stand-ins for the electronics (assembly view only) ----------
module board_slide() {
  color("#1D6B3A") translate([-board[0]/2, board_y0, board_z]) cube(board);
  color("#262626") translate([-9, 1, board_z + 9.5]) cube([18, 22.4, 1.2]);                      // ESP32-C3
  color("#C9C9C9") translate([-4.5, 16, board_z + 10.7]) cube([9, 7.4, 3.2]);                     // USB-C
  for (s = [-1, 1], i = [0 : 8], c = [0 : 2])
    color(c == 0 ? "#C9A227" : c == 1 ? "#E24B4A" : "#444441")
      translate([s*(11.4 + 1.2*c) - 0.32, -9 + 3*i - 0.32, board_z + board[2]]) cube([0.64, 0.64, 9]);
}
module plate_parts() {
  color("#D85A30") translate([mpu_cx - mpu[0]/2, groove_y0, plate_z1]) cube(mpu);                 // MPU-6050
  color("#6A4BC2") translate([amp_cx - amp[0]/2, groove_y0, plate_z1]) cube(amp);                 // amp
  color("#2a7a3a") translate([amp_cx - 4, groove_y0 + 0.4, plate_z1 + amp[2]]) cube([8, 4, 6.9]); // speaker terminal
}
module face_parts() {
  yi = rack_yf + face_t;
  color("#2B2B2B") translate([-speaker[0]/2, yi, spk_z0]) cube(speaker);
  color("#1F5FA8") translate([-oled[0]/2, yi + glass[1], oled_z0]) cube(oled);
  color("#111111") translate([-glass[0]/2, yi, oled_z0 + glass_up]) cube(glass);
}
module lid_parts() {
  color("#6A4BC2") translate([mic_xy[0], mic_xy[1], lid_top - 2.2]) cylinder(d = mic_d, h = 1.2);
  color("#C0392B") translate([-touch[0]/2, touch_y0, lid_top]) cube([touch[0], touch[1], 1.4]);
}
module batteries() for (s = [-1, 1])
  color("#85B7EB") translate([s < 0 ? -rack_xi + 0.6 : rack_xi - 0.6 - battery[0], face_yb + 0.5, in_z + 0.4]) cube(battery);

// ---------- views ----------
e = explode;
if (part == "assembly") {
  color("#534AB7") translate([0, 0, e*0.5]) collar();
  color("#B9B7AD") rack();
  color("#5DCAA5") translate([0, -e*0.9, 0]) face();
  color("#1D9E75") translate([0, -e*1.6, 0]) front();
  if (show_electronics) translate([0, -e*0.9, 0]) face_parts();
  if (show_electronics) translate([0, e*1.4, 0]) board_slide();
  if (show_electronics) translate([0, e*1.1, 0]) plate_parts();
  if (show_battery) translate([0, e*1.25, 0]) batteries();
  if (show_electronics) lid_parts();
  color("#E8825F", 0.95) translate([0, 0, e*3.4]) shell();
}
else if (part == "shell")  rotate([180, 0, 0]) translate([0, 0, -shell_z1]) shell();   // top on the bed
else if (part == "collar") translate([0, 0, -base_top]) collar();
else if (part == "rack")   rack();                                                      // on its bottom
else if (part == "face")   translate([0, 0, -(rack_yf + face_t)]) rotate([90, 0, 0]) face();   // front on the bed
else if (part == "front")  translate([0, 0, -rack_yf]) rotate([90, 0, 0]) front();               // face down, pegs up
// Parts in their assembled position (used by scripts/check_fit.sh)
else if (part == "fit_shell")  shell();
else if (part == "fit_collar") collar();
else if (part == "fit_rack")   rack();
else if (part == "fit_face")   face();
else if (part == "fit_front")  front();
