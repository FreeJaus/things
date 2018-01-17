include <../../c3d_params.scad>;

module defender_symbol() {
  scale([.015,.015,.015]) import("../../ext/Hylian_Shield.stl");
}

module defender() {
  cylinder(r=2.5,h=15);
  translate([0,0,15]) cylinder(r1=2.5, r2=1.5, h=5);
  translate([0,-1,.5]) {
  translate([0,1,22.5]) rotate([90,0,45]) {
    //cylinder(r=2.5,h=2);
    //translate([-1.75,-1.55,2]) linear_extrude(1) text("D",4);
    translate([0,0,.2]) defender_symbol();
    hull() {
      defender_symbol();
      rotate([0,180,0]) defender_symbol();
    }
    translate([0,0,-.2]) rotate([0,180,0]) defender_symbol();
  }
  }
}
