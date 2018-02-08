include <../../c3d_params.scad>;

module knight_flag() {
  translate([5*nozzle,-.5,2*nozzle]) cube([9,1,5]);
  difference() {
    cylinder(r=6*nozzle,h=5+2*nozzle);
    translate([0,0,-nozzle]) cylinder(r=4*nozzle,h=5+nozzle);
  }
}
