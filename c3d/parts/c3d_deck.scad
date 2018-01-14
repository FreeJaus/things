include <../c3d_params.scad>;
use <markers/c3d_victory.scad>;
use <markers/c3d_cities_markers.scad>;
use <markers/c3d_victory_road.scad>;
use <markers/c3d_army.scad>;
use <markers/c3d_chit.scad>;
use <cities_knights/c3d_knight.scad>;
use <seafarers/c3d_ship.scad>;
use <c3d_road.scad>;

inner_wall = 4*nozzle;
outer_wall = 3*nozzle;
wall_height = 10;

module hull_box(l,w,h,r) {
  linear_extrude(h) hull() {
    translate([r,r,0]) circle(r);
    translate([l-r,r,0]) circle(r);
    translate([l-r,w-r,0]) circle(r);
    translate([r,w-r,0]) circle(r);
  }
}

//soporte para cartas (en la mano)

module deck() {
  l = 190;
  w = 100;

  translate([0,0,6*base_thickness-10]) {
    translate([61.25,5.25,0]) %victory();
    translate([12.25,5.25,0]) %army();
    translate([19.25,5.25,0]) %victory_road();

    translate([5.25,14.75,0]) %coins();
    translate([5.25,25.75,0]) %cloth();
    translate([5.25,36.75,0]) %books();
  }

  difference() {
    union() {
      cube([l,w,base_thickness]);
      translate([outer_wall+.5*nozzle, outer_wall+.5*nozzle, base_thickness]) hull_box(l-2*outer_wall-nozzle,w-2*outer_wall-nozzle, 10, 1);
    }
    translate([outer_wall+3.5*nozzle, 5+outer_wall+2.5+8*nozzle, base_thickness+10-2*nozzle]) union() {
      offset = 6.5+11.5*nozzle;
      translate([2.5+.5*nozzle,2.5+.5*nozzle,0]) for (j = [0:2]) {
        translate([-2.5,j*offset+5,0]) cube([2.5-3.625*nozzle+(30+30*nozzle),2*nozzle,20]);
        translate([0,j*offset,-10]) cylinder(r=2.5+.5*nozzle,h=20);
        translate([2.5+4*nozzle,j*offset-2.5,0]) cube([2*nozzle,5,20]);
        translate([5+10*nozzle,j*offset,0]) for (i = [0:4]) {
          translate([i*(5+5*nozzle), 0, -10]) cylinder(r=2.5+.5*nozzle,h=20);
        }
        translate([13+16.25*nozzle,j*offset-2.5-3*nozzle,0]) difference() {
          cube([15+15*nozzle, 5+6*nozzle, 20]);
          translate([6.625+nozzle,nozzle,0]) cube([10.375+8*nozzle, 5+4*nozzle, 20]);
        }
        //--
        translate([-2.5,-5-2*nozzle,0]) cube([130+23*nozzle,2*nozzle,20]);
        translate([0, -7.5-4.5*nozzle, 0]) for (i = [0:19]) {
          translate([i*(5+5*nozzle), 0, -10]) cylinder(r=2.5+.5*nozzle,h=20);
        }
      }
      translate([.5*base_segment_length,10+2*nozzle,0]) {
        translate([-2.75,0,.5*base_segment_length-7.5])
        //%for (j = [0:4]) for (i = [0:2])  translate([j*10, i*(4+2*nozzle),-1.75]) rotate([0,90,90]) road();
        //for (j = [0:4]) for (i = [0:2])  translate([j*10-5.25-nozzle, -nozzle+i*(4+2*nozzle),-10]) cube([5+2*nozzle,4+nozzle,20]);
        translate([50,0,0]) {
          %for (i = [0:14])  translate([-5+i*(4.5+4*nozzle), nozzle+.5*base_segment_width, -1.75]) rotate([0,90,0]) road();
          for (i = [0:14])  translate([i*(4.5+4*nozzle)-5.25-nozzle, 0, -10]) cube([4+nozzle, 5+2*nozzle, 20]);
        }

        translate([0,25,0])
        for (j = [0:2]) for (i = [0:4]) {
          translate([j*17.5-.5*base_segment_length+.5*base_segment_width, 8.5*i,-base_thickness+1.5*nozzle]) hull() {
            cylinder(r=.5*base_segment_width+.5*nozzle,h=base_thickness+.5*nozzle);
            translate([base_segment_length-base_segment_width,0,0]) cylinder(r=.5*base_segment_width+.5*nozzle,h=base_thickness+nozzle);
          }
          %translate([j*17.5, 8.5*i,-base_thickness+1.5*nozzle]) rotate([0,0,0]) ship();
        }
      }
      translate([65,29.5,0]) {
        for (j = [0:3]) for (i = [0:1]) translate([j*(2*base_radius+4*nozzle), i*(2*base_radius+4*nozzle),-1.75]) cylinder(r=base_radius+nozzle,h=20);
      }
      translate([150,0,0]) {
        for (j = [0:1]) for (i = [0:2]) translate([j*(2*base_radius+4*nozzle), i*(2*base_radius+4*nozzle),-1.75]) {
            %translate([0,0,1.75]) knight(i);
            cylinder(r=base_radius+nozzle,h=20);
        }
      }
    }
  }
//  translate([0,0,50]) cube([l,w,3*base_thickness]);
}
