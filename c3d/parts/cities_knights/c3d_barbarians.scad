include <../../c3d_params.scad>;

module barbarians() {
  cylinder(r=2.5,h=10);
  translate([0,0,10]) difference() {
    scale([0.7,0.7,0.7]) import("../../ext/pirate.STL");
    //translate([-2,-1.3,-5]) cube([10,2.5,25]);
  }
}
