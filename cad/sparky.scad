// Sparky - modular ESP32-C3 desk buddy.
// Open in OpenSCAD. Choose a part with the Customizer, or from the command line:
//   openscad -D 'part="rack"' -o ../stl/rack.stl sparky.scad
include <config.scad>
use <parts/shell.scad>
use <parts/collar.scad>
use <parts/rack.scad>
use <parts/crown.scad>
use <parts/base.scad>
use <parts/lid.scad>

/* [View] */
part = "assembly"; // [assembly, shell, collar, rack, crown, base, lid]
explode = 0;       // [0:5:60]
show_electronics = true;

module electronics_top() {
  color("#C0392B") translate([-11, 0, crown_top]) cube([22, 18, 1.6]);                       // touch
  color("#6A4BC2") translate([0, mic_y, crown_top]) cylinder(d = 14, h = 1.6);               // mic
}

module electronics_low() {
  color("#1F5FA8") translate([-17.7, -21.0, oled_hole_z - 16.75]) cube([35.4, 1.6, 33.5]);  // OLED
  color("#111")    translate([-17, -22.6, screen_z]) cube([34, 1.6, screen_h]);
  color("#1D6B3A") translate([-14, -16, shelf_z + rack_t]) cube([28, 34, 1.6]);             // expansion board
  color("#262626") translate([-9, -2, shelf_z + rack_t + 9.5]) cube([18, 22.5, 1.2]);         // ESP32-C3
  color("#2B2B2B") translate([15.5, -11, 17.5]) cube([5, 20, 40]);                              // speaker
  color("#8FB3D9") translate([-battery[0]/2, -battery[1]/2, lid_t + 0.2]) cube(battery);     // LiPo
}

if (part == "assembly") {
  color("#8A887F") translate([0, 0, -explode]) lid();
  color("#9A988F") base();
  color("#534AB7") translate([0, 0, base_h + explode*0.5]) collar();
  color("#B9B7AD") translate([0, 0, explode]) rack();
  color("#D3D1C7") translate([0, explode*0.4, explode*1.6]) crown();
  if (show_electronics) translate([0, 0, explode]) electronics_low();
  if (show_electronics) translate([0, explode*0.4, explode*1.6]) electronics_top();
  color("#E8825F", 0.9) translate([0, 0, explode*3]) shell();
}
else if (part == "shell")  translate([0, 0, -shell_z0]) shell();
else if (part == "collar") collar();
else if (part == "rack")   translate([0, 0, -rack_z0]) rack();
else if (part == "crown")  rotate([180, 0, 0]) translate([0, 0, -crown_top]) crown();   // print top-down
else if (part == "base")   rotate([180, 0, 0]) translate([0, 0, -base_h]) base();   // print deck-down
else if (part == "lid")    lid();
