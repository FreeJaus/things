include <../c3d_params.scad>;

module road() {
 translate([-.5*base_segment_length+.5*base_segment_width,0,0]) hull() {
   cylinder(r=.5*base_segment_width,h=base_thickness+nozzle);
   translate([base_segment_length-base_segment_width,0,0]) cylinder(r=.5*base_segment_width,h=base_thickness+nozzle);
 }
 translate([0,0,base_thickness+1.75*nozzle]) cube([base_segment_length,base_segment_width,3*nozzle],center=true);
 for (i = [0:1]) translate([0,-.375*base_segment_width+i*0.75*base_segment_width,base_thickness+3*nozzle]) rotate([-90,0,90]) cylinder(r=.125*base_segment_width,h=base_segment_length,center=true);
}
