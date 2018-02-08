include <../../c3d_params.scad>;

module wall() {
 r = base_radius;
 r2 = r+2;
 cylinder(r=r,h=base_thickness);
 translate([0,0,base_thickness]) difference(){
   union() {
     cylinder(r=.9*r,h=1);
     translate([0,0,1]) cylinder(r1=.9*r,r2=r2,h=7);
   }
   for (i = [0:2]) {
     rotate([0,0,i*120]) translate([.75*base_radius,0,0]) {
       translate([0,0,2]) rotate([0,90,0]) cylinder(r=3-nozzle,h=1.5*base_radius);
       translate([0,-3+nozzle,0]) cube([1.5*base_radius,6-2*nozzle,2]);
     }
   }
 }
 translate([0,0,base_thickness+8]) cylinder(r=r2,h=3*nozzle);

 translate([0,0,base_thickness+8]) difference() {
   cylinder(h=3,r=r2);
   union() {
     translate([0,0,-.5]) cylinder(h=4,r=r+nozzle);
     for (i = [0:2]) {
       rotate([0,0,i*120]) translate([-1.25*base_radius,-1.5,0]) cube([2.5*base_radius,3,4]);
     }
   }
 }
}

