include <../../c3d_params.scad>;

module victory_road_symbol() {
  scale([.45,.55,.40]) import("../../ext/Catan_road.stl");
}

module victory_road() {
  cylinder(r=2.5,h=15);
  translate([0,0,15]) cylinder(r1=2.5, r2=1.5, h=5);
  translate([-.35,0,16.5]) rotate([90,0,0]) {
    //cylinder(r=2.5,h=2);
    //translate([-1.75,-1.55,2]) linear_extrude(1) text("R",4);
    rotate([0,0,15]) victory_road_symbol();
    translate([0,11.5,0]) rotate([0,180,165]) victory_road_symbol();
  }
}
