include <../../c3d_params.scad>;

module army_symbol() {
  scale([.22,.44,.21]) import("../../ext/IkeSword_001_Halved.stl");
}

module army() {
  cylinder(r=2.5,h=10);
  translate([0,0,10]) cylinder(r1=2.5, r2=1.35, h=5);
  difference() {
    translate([0,0,12.5]) rotate([180,0,45]) {
      //cylinder(r=2.5,h=2);
      //translate([-1.75,-1.55,2]) linear_extrude(1) text("A",4);
      army_symbol();
      rotate([0,0,180]) army_symbol();
    }
    translate([0,0,-50]) cylinder(r=2.5, h=50);
  }
}
