include <../../c3d_params.scad>;

module barbarians() {
  cube([5,2.5,15]);
  difference() {
    rotate([90,0,0]) scale([0.7,0.7,0.7]) import("../ext/Catan_Boat_v02.17.12.STL");
    translate([-2,-1.3,-5]) cube([10,2.5,25]);
  }
}
