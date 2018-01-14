include <../../c3d_params.scad>;

module ship() {
  translate([-.5*base_segment_length+.5*base_segment_width,0,0]) hull() {
    cylinder(r=.5*base_segment_width,h=base_thickness+nozzle);
    translate([base_segment_length-base_segment_width,0,0]) cylinder(r=.5*base_segment_width,h=base_thickness+nozzle);
  }
  translate([0,0,base_thickness-1.45]) rotate([0,0,90]) scale([0.1,0.1,0.1]) import("../../ext/boat.stl");
}
