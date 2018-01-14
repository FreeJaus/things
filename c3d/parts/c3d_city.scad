include <../c3d_params.scad>;

module city() {
  r1 = base_radius;
  h1 = base_radius-base_thickness;
  r2 = .6*base_radius;
  h2 = 2*base_radius;
  cylinder(h=base_thickness,r=r1);
  translate([0,0,base_thickness]) difference() {
    cylinder(h=h1+3,r=.85*r1);
    translate([0,0,h1]) for (i = [0:2]) {
      rotate([0,0,i*120]) translate([-1.25*base_radius,-1.5,0]) cube([2.5*base_radius,3,4]);
    }
    translate([base_radius-2-.15*base_radius,-2.5,-2]) cube([2,5,6]);
  }
  translate([0,0,h1]) {
    difference() {
      cylinder(r=r2,h=.7*h2);
      for (i = [0:2]) {
        rotate([0,0,60+i*120]) translate([.5*base_radius-1,-1.5,8]) cube([2,3,3]);
      }
    }
    difference() {
      translate([0,0,.7*h2]) cylinder(h=.3*h2,r1=r2,r2=0);
      translate([0,0,h2-1]) cylinder(h=6,r=2);
    }
  }
}
