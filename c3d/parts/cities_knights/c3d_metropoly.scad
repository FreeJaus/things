include <../../c3d_params.scad>;

module metropoly() {
  difference() {
    union(){
      difference(){
          translate([0,0,-4.5])cylinder(r=base_radius,h=4+3*nozzle);
          for (i=[0:5]){
              rotate([0,0,i*60]) translate([.75*base_radius,0,-4.5]) {
              translate([1.5,0,3.5]) rotate([0,90,0]) cylinder(r=1.5-nozzle,h=1.5*base_radius);
              translate([1.5,-1.5+nozzle,3.5-(2.32/2+(1.5-nozzle))]) cube([1.5*base_radius,3-nozzle*2,2.32]);
              }
          }
      }
      for (i=[0:5]){
          rotate([0,0,i*60]) translate([.75*base_radius,0,-4.5]) {
              translate([1.5,(-1.5+nozzle)-((3.25-nozzle*2)-(3-nozzle*2))/2,3.5-(2.32/2+(1.5-nozzle)+0.25)]) cube([.12*base_radius,3.25-nozzle*2,0.25]);
              }
          }
      translate([0,0,-7.5]) cylinder(r1=2+.6*base_radius, r2=base_radius, h=3); 
      translate([0,0,-7.5-2*nozzle]) cylinder(r=2+.6*base_radius,h=2*nozzle);
      }
    translate([0,0,-9]) cylinder(r=.6*base_radius+.5*nozzle,h=9);
  }
  translate([0,0,-.5+3*nozzle]) difference() {
    cylinder(r=base_radius,h=2);
    translate([0,0,-.5]) union() {
      for (i = [0:11]) {
        rotate([0,0,i*30]) translate([-10,-1.1,0]) cube([20,2.2,3]);
      }
      cylinder(r=base_radius-2,h=3);
    }
  }
}
