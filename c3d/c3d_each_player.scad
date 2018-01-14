/*
# For each player

- 5x Settlement
- 4x City
- 15x Road

## Cities & Knights

- Tiered Knights:
  - 2x Basic Knights
  - 2x Strong Knights
  - 2x Mighty Knights
- 3x City Walls
- City Development Calendars

## Seafarers

- 15x ships

---

- https://catanshop.com/replacement-wood-settlers-of-catan [$7]
- https://catanshop.com/replacement-wood-cities-knights-expansion [$7]
- https://catanshop.com/replacement-wood-seafarers-expansion [$7]
- https://catanshop.com/replacement-wood-traders-barbarians-expansion [$7]

*/

include <c3d_params.scad>;
use <parts/c3d_deck.scad>;
use <parts/c3d_settlement.scad>;
use <parts/c3d_city.scad>;
use <parts/c3d_road.scad>;
use <parts/seafarers/c3d_ship.scad>;
use <parts/cities_knights/c3d_knight.scad>;
use <parts/cities_knights/c3d_wall.scad>;
use <parts/markers/c3d_cities_markers.scad>;
use <parts/markers/c3d_victory.scad>;

%translate([-base_radius-2.5,-60,-nozzle]) cube([180,100,nozzle]);

translate([0,50,-nozzle]) {
   %cube([165,115,nozzle]);
   translate([3,2,0]) deck();
   translate([0,125,-nozzle]) {
      %cube([165,115,nozzle]);
      translate([3,2,0]) deck_top();
   }
}

translate([150,-20,0]) {
  translate([5.25,14.75,0]) coins();
  translate([5.25,24.75,0]) cloth();
  translate([5.25,34.75,0]) books();
  translate([5.25,44.75,0]) victory();
}

clearance = 4+4*nozzle;

for (i = [0:4]) translate([i*(2*base_radius+clearance-4),0,0]) settlement();
translate([0,(2*base_radius+clearance),0]) for (i = [0:3]) translate([i*(2*base_radius+clearance-4),0,0]) city();
translate([65,-30,0]) for (j = [0:2]) for (i = [0:4])  translate([i*22,j*7,0]) road();
translate([65,-55,0]) for (j = [0:2]) for (i = [0:4]) translate([i*20,j*8.75,0]) ship();
translate([0,-47.5,0]) for (j = [0:1]) for (i = [0:2]) translate([i*(2*base_radius+clearance-4),j*(2*base_radius+.75*clearance),0]) knight(i+1);
translate([132,-7.5,0]) for (j = [0:2]) for (i = [0:1]) translate([i*5, i*6.5+j*13,5+2*nozzle]) rotate([180,0,0]) knight_flag();
translate([4+4*(2*base_radius+clearance-4),(2*base_radius+clearance),0]) wall();
translate([8+5*(2*base_radius+clearance-4),(2*base_radius+clearance),0]) wall();
translate([8+5*(2*base_radius+clearance-4),0,0]) wall();
