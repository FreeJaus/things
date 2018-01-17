$fn=144;

nozzle = 0.4;

base_radius = 10;
base_thickness = 1.2;
base_segment_length = 20;
base_segment_width = 5;
base_tile_side = nozzle+base_segment_length+2*base_radius;

// Deck(s)

min_clearance = 4*nozzle;
main_clearance = 2*(base_radius+nozzle)+min_clearance;

outer_wall = 3*nozzle;
wall_height = 10;
rs_l = base_segment_width+2*nozzle+5; // Road/ship hole height
rs_w = base_thickness+2*nozzle+5;     // Road/ship hole width
vr_h = 5+13*nozzle+4*min_clearance;
deck_l = 2*outer_wall+2*nozzle+4*main_clearance+2*min_clearance+5*(rs_l+min_clearance);
deck_w = 2*outer_wall+2*nozzle+4*main_clearance+min_clearance + vr_h;

module hull_box(l,w,h,r) {
  linear_extrude(h) hull() {
    translate([r,r,0]) circle(r);
    translate([l-r,r,0]) circle(r);
    translate([l-r,w-r,0]) circle(r);
    translate([r,w-r,0]) circle(r);
  }
}
