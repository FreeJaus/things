include <c3d_params.scad>;
use <parts/cities_knights/c3d_knight.scad>;
use <parts/seafarers/c3d_ship.scad>;


knight(1);
translate([base_radius*2.5,0,0])
knight(2);
translate([-base_radius*2.5,0,0])
knight(3);


//ship();