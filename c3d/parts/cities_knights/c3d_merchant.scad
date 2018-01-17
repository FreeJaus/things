include <../../c3d_params.scad>;

module merchant() {
 cylinder(r=.6*base_radius,h=base_thickness);
 translate([-1,24,0]) scale([1.2,1.2,1.2]) import("../../ext/peasant.STL");
}
