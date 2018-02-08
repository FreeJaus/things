include <../c3d_params.scad>;

module settlement() {
 r = base_radius;
 r2 = .875*r;
 h1 = base_radius;
 h2 = .85*base_radius;
 cylinder(h=base_thickness,r=r);
 translate([0,0,base_thickness]) difference() {
   cylinder(h=h1-base_thickness,r=.75*r);
   for (i = [0:2]) {
     rotate([0,0,i*120]) translate([.75*r-2,-2.5,-2]) cube([2,5,6]);
   }
 }
 translate([0,0,h1]) {
   cylinder(r=r2,h=2);
   translate([0,0,2]) difference() {
     cylinder(h=h2,r1=r2,r2=0);
     translate([0,0,h2-1]) cylinder(h=6,r=2);
   }
 }
}
/*
for (i = [0:2]) {
  rotate([0,0,i*120]) translate([.75*base_radius,0,0]) {
    translate([0,0,2]) rotate([0,90,0]) cylinder(r=3,h=1.5*base_radius);
    translate([0,-3,0]) cube([1.5*base_radius,6,2]);
  }
}
*/
