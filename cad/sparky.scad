// Sparky - modular ESP32-C3 desk buddy.
// Open in OpenSCAD. Choose a part with the Customizer, or from the command line:
//   openscad -D 'part="rack"' -o ../stl/sparky_rack.stl sparky.scad
// Single parts come out in their print orientation, on the bed.
include <config.scad>
use <parts/shell.scad>
use <parts/collar.scad>
use <parts/base.scad>
use <parts/rack.scad>
use <parts/face.scad>
use <parts/plate.scad>
use <parts/lid.scad>

/* [View] */
part = "assembly"; // [assembly, shell, collar, base, rack, face, plate, lid]
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
  color("#D85A30") translate([-mpu[0]/2, -8.6, plate_z1]) cube(mpu);                               // MPU-6050
  color("#6A4BC2") translate([-amp[0]/2, -12.4, plate_z0 - 1.2 - amp[2]]) cube(amp);               // amp
  color("#2a7a3a") translate([-4, -12.4 + amp[1] - 4.4, plate_z0 - 1.2 - amp[2] - 6.9]) cube([8, 4, 6.9]); // terminal
}
module face_parts() {
  yi = rack_yf + face_t;
  color("#2B2B2B") translate([-speaker[0]/2, yi, spk_z0]) cube(speaker);
  color("#1F5FA8") translate([-oled[0]/2, yi + glass[1], oled_z0]) cube(oled);
  color("#111111") translate([-glass[0]/2, yi, oled_z0 + glass_up]) cube(glass);
}
module lid_parts() {
  color("#6A4BC2") translate([mic_xy[0], mic_xy[1], lid_top - 2.2]) cylinder(d = mic_d, h = 1.2);
  color("#C0392B") translate([-touch[0]/2, 6.5, lid_top]) cube([touch[0], touch[1], 1.4]);
}
module batteries() for (s = [-1, 1])
  color("#85B7EB") translate([s < 0 ? -rack_xi + 0.6 : rack_xi - 0.6 - battery[0], face_yb + 0.5, in_z + 0.4]) cube(battery);

// ---------- views ----------
e = explode;
if (part == "assembly") {
  color("#888780") translate([0, 0, -e*0.6]) base();
  color("#534AB7") translate([0, 0, -e*0.3]) collar();
  color("#B9B7AD") rack();
  color("#5DCAA5") translate([0, -e*0.9, 0]) face();
  if (show_electronics) translate([0, -e*0.9, 0]) face_parts();
  if (show_electronics) translate([0, e*1.4, 0]) board_slide();
  color("#D3D1C7") translate([0, e*1.1, e*0.25]) { plate(); }
  if (show_electronics) translate([0, e*1.1, e*0.25]) plate_parts();
  if (show_battery) translate([0, e*1.25, 0]) batteries();
  color("#B4B2A9") translate([0, 0, e*1.4]) { lid(); }
  if (show_electronics) translate([0, 0, e*1.4]) lid_parts();
  color("#E8825F", 0.95) translate([0, 0, e*3.4]) shell();
}
else if (part == "shell")  rotate([180, 0, 0]) translate([0, 0, -shell_z1]) shell();   // top on the bed
else if (part == "collar") translate([0, 0, -base_top]) collar();
else if (part == "base")   rotate([180, 0, 0]) translate([0, 0, -base_top]) base();   // top on the bed
else if (part == "rack")   translate([0, 0, -floor_z]) rack();
else if (part == "face")   translate([0, 0, -rack_yf]) rotate([90, 0, 0]) translate([0, 0, 0]) face();  // front on the bed
else if (part == "plate")  translate([0, 0, rack_yb]) rotate([-90, 0, 0]) plate();                   // back edge on the bed
else if (part == "lid")    translate([0, 0, -rack_top]) lid();
// Parts in their assembled position (used by scripts/check_fit.sh)
else if (part == "fit_shell")  shell();
else if (part == "fit_collar") collar();
else if (part == "fit_base")   base();
else if (part == "fit_rack")   rack();
else if (part == "fit_face")   face();
else if (part == "fit_plate")  plate();
else if (part == "fit_lid")    lid();
