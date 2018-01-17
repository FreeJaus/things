include <../c3d_params.scad>;

module robber() {
 //cylinder(h=base_radius,r=base_radius);
 scale([.476, .476, .476]) import("../ext/thing456765_twister_robber.stl");
}
