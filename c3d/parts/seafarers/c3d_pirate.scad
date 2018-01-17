include <../../c3d_params.scad>;

module pirate() {
  hull() {
    translate([0,base_radius-4,0])cylinder(r=4,h=base_thickness);
    translate([0,-base_radius+4,0]) cylinder(r=4,h=base_thickness);
  }
  translate([0,.5,base_thickness+0.1])
  scale([1.1,1.1,1.1]) import("../../ext/pirate_fix.STL");
}

pirate();
