include <../../c3d_params.scad>;
include <../../ext/star_3d.scad>;

module chit() {
  cylinder(r=2.5,h=15);
  translate([0,0,15]) cylinder(r1=2.5, r2=1.5, h=5);
  translate([0,0,22.5]) rotate([90,180,45]) {
    star_3d(points = _points, point_len = _point_len, adjust = _adjust, pnt_h = _pnt_h, cent_h =_cent_h, rnd = _rnd, fn = _fn);
    rotate([0,180,0]) star_3d(points = _points, point_len = _point_len, adjust = _adjust, pnt_h = _pnt_h, cent_h =_cent_h, rnd = _rnd, fn = _fn);
  }
}
