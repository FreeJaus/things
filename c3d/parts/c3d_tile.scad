include <../c3d_params.scad>;

//https://www.thingiverse.com/thing:2035221

module hex_r(r, h) {
 b=60; d=2*r*sin(b);
 translate([0,0,h/2]) {
  for (t = [-b, 0, b]) rotate([0,0,t]) cube([r, d, h], true);
 }
}

module tile() {
  r = base_tile_side;
  difference() {
    hex_r(r, 2*base_thickness);
    for (i = [0 : 5]) rotate([0,0,i*60]) {
      translate([r,0,base_thickness]) cylinder(r=base_radius+.5*nozzle, h=2*base_thickness);
      translate([r,0,base_thickness]) rotate([0,0,30]) translate([-(.5*base_segment_width+.5*nozzle),0,0]) cube([1+.5*base_segment_width+.5*nozzle, base_tile_side, 2*base_thickness]);
    }
  }
}
