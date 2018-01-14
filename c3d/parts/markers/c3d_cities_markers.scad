include <../../c3d_params.scad>;

module coins() {
  cylinder(r=2.5,h=20);
  translate([0,1,22.5]) rotate([90,0,0]) {
    cylinder(r=2.5,h=2);
    translate([-1.75,-1.55,2]) linear_extrude(1) text("coins",4);
  }
}

module cloth() {
  cylinder(r=2.5,h=20);
  translate([0,1,22.5]) rotate([90,0,0]) {
    cylinder(r=2.5,h=2);
    translate([-1.75,-1.55,2]) linear_extrude(1) text("cloth",4);
  }
}

module books() {
  cylinder(r=2.5,h=20);
  translate([0,1,22.5]) rotate([90,0,0]) {
    cylinder(r=2.5,h=2);
    translate([-1.75,-1.55,2]) linear_extrude(1) text("books",4);
  }
}
