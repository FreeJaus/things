include <c3d_params.scad>;
use <parts/c3d_deck.scad>;
use <parts/c3d_tile.scad>;
use <parts/c3d_settlement.scad>;
use <parts/c3d_city.scad>;
use <parts/c3d_road.scad>;
use <parts/seafarers/c3d_ship.scad>;
use <parts/cities_knights/c3d_knight.scad>;
use <parts/cities_knights/c3d_wall.scad>;
use <parts/cities_knights/c3d_metropoly.scad>;

//---

translate([100,100,0]) deck();

//---

tile(50,2);
d=sin(60)*(base_tile_side);
translate([.5*base_tile_side,d,base_thickness]) rotate([0,0,-60]) settlement();
translate([-.5*base_tile_side,d,base_thickness]) city();
  //cylinder(r=.05,h=10);

translate([-base_tile_side,0,base_thickness]) {
  rotate([0,0,-60]) wall();
  translate([0,0,10]) city();
}
translate([base_tile_side,2*d,base_thickness]) {
  city();
  translate([0,0,2.8*base_radius]) metropoly();
}
translate([.5*base_tile_side,3*d,base_thickness]) {
  rotate([0,0,-60]) wall();
  translate([0,0,10]) city();
  translate([0,0,10+2.8*base_radius]) metropoly();
}
translate([-.5*base_tile_side,-d,base_thickness]) {
    knight(1);
}
translate([.5*base_tile_side,-d,base_thickness]) {
    knight(2);
}
translate([base_tile_side,0,base_thickness]) {
    rotate([0,0,30]) knight(3);
}

translate([0,d,base_thickness]) road();
translate([sin(60)*d,0.5*d,base_thickness]) rotate([0,0,-60]) road();
translate([-sin(60)*d,0.5*d,base_thickness]) rotate([0,0,60]) road();

translate([sin(60)*d,2.5*d,base_thickness]) rotate([0,0,-60]) ship();
translate([1.5*base_tile_side,2*d,base_thickness]) ship();
translate([1.5*base_tile_side+sin(60)*d,1.5*d,base_thickness]) rotate([0,0,-60]) ship();
translate([1.5*base_tile_side+sin(60)*d,.5*d,base_thickness]) rotate([0,0,60]) ship();
translate([1.5*base_tile_side,0,base_thickness]) ship();
translate([sin(60)*d,-.5*d,base_thickness]) rotate([0,0,60]) ship();

translate([0,2*d,0]) tile(50,2);

translate([2*sin(60)*d,d]) tile(50,2);
