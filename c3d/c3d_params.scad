$fn=144;

nozzle = 0.4;

base_radius = 10;
base_thickness = 2;
base_segment_length = 20;
base_segment_width = 5;
base_tile_side = nozzle+base_segment_length+2*base_radius;

module base_road() {
 hull() {
   cylinder(r=.5*base_segment_width,h=base_thickness);
   translate([base_segment_length-base_segment_width,0,0]) cylinder(r=.5*base_segment_width,h=base_thickness);
 }
}
