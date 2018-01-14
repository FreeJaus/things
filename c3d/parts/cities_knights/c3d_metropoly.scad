include <../../c3d_params.scad>;

module metropoly() {
  difference() {
    union(){
      translate([0,0,-5]) cylinder(r=base_radius,h=4+3*nozzle);
      translate([0,0,-7.5]) cylinder(r1=2+.6*base_radius, r2=base_radius, h=3);
    }
    translate([0,0,-9]) cylinder(r=.6*base_radius+.5*nozzle,h=9);
  }
  translate([0,0,-7.5-2*nozzle]) cylinder(r=2+.6*base_radius,h=2*nozzle);

  translate([0,0,-1+3*nozzle]) difference() {
    cylinder(r=base_radius,h=2);
    translate([0,0,-.5]) union() {
      for (i = [0:2]) {
        rotate([0,0,60+i*120]) translate([-10,-1.5,0]) cube([20,3,3]);
      }
      cylinder(r=base_radius-2,h=3);
    }
  }
}
