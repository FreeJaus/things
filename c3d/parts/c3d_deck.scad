include <../c3d_params.scad>;
use <markers/c3d_victory.scad>;
use <markers/c3d_cities_markers.scad>;
use <markers/c3d_victory_road.scad>;
use <markers/c3d_army.scad>;
use <markers/c3d_chit.scad>;
use <cities_knights/c3d_knight.scad>;
use <cities_knights/c3d_wall.scad>;
use <seafarers/c3d_ship.scad>;
use <c3d_road.scad>;
use <c3d_settlement.scad>;
use <c3d_city.scad>;

module improvements() {
  clearance = 2*nozzle;
  translate([2.5+.5*nozzle, 2.5+2.5*nozzle, 0]) {
    translate([0,0,-10+clearance]) cylinder(r=2.5+.5*nozzle,h=20);
    translate([2.5+.5*nozzle+2*clearance, 0, 0]) {
      translate([0, -2.5, 0]) cube([clearance,5,20]);
      translate([2.5+3*clearance, 0, 0]) {
        for (i = [0:1]) {
          translate([i*(5+nozzle+2*clearance), 0, -10+clearance]) cylinder(r=2.5+.5*nozzle,h=20);
        }
        translate([7.5+1.5*nozzle+2*clearance, 0, 0]) {
          translate([clearance,-(2.5+clearance),0]) difference() {
              cube([15*(1+nozzle), 5*(1+nozzle), 20]);
              translate([5*(1+nozzle),nozzle,0]) cube([10*(1+nozzle)-nozzle, 5+3*nozzle, 20]);
          }
          translate([2.5+.5*nozzle+2*clearance, 0, 0]) {
            translate([0, 0, -10+clearance]) cylinder(r=2.5+.5*nozzle,h=20);
            translate([5+nozzle+2*clearance, 0, 0]) {
              for (i = [0:1]) {
                translate([i*(5+nozzle+2*clearance), 0, -10+clearance]) cylinder(r=2.5+.5*nozzle,h=20);
              }
            }
          }
        }
      }
    }
  }
}

module victory_rule(l) {
  translate([0,3*min_clearance,0]) {
    cube([l, 2*nozzle, 20]);
    clearance = 2*nozzle;
    translate([ 2.5+4.5*nozzle+2*clearance, 2.5+.5*nozzle+3*clearance, 0]) {
      translate([-2.5-3.5*nozzle-clearance, 0, -clearance]) cylinder(r=1*nozzle,h=20);
      translate([0,0,-10+2*nozzle]) {
        %victory_road();
        translate([5+2*clearance+nozzle,0,0]) %army();
        translate([10+4*clearance+2*nozzle,0,0]) %victory();
      }
      for (j = [0:3]) {
        translate([j*3*clearance+(j*5)*(5+nozzle+2*clearance),0,0]) {
          for (i = [0:4]) {
            translate([i*(5+nozzle+2*clearance), 0, -10+clearance]) cylinder(r=2.5+.5*nozzle,h=20);
          }
          translate([4*(5+nozzle+2*clearance)+2.5+5.5*nozzle, 0, -clearance]) cylinder(r=1*nozzle,h=20);
        }
      }
    }
  }
  translate([ 0, vr_h-2*nozzle-min_clearance, 0]) cube([l, 2*nozzle, 20]);
  translate([ -20, .5*min_clearance, -9+2*nozzle]) rotate([-5,0,0]) cube([l+40, min_clearance, 20]);
}

module deck_top() {
  difference() {
    hull_box(deck_l,deck_w, 40+base_thickness,1);
    translate([outer_wall+nozzle, outer_wall+nozzle, base_thickness]) hull_box(deck_l-2*outer_wall,deck_w-2*outer_wall, 50, 1);
  }
}

module deck() {
  //#translate([outer_wall+nozzle, outer_wall+nozzle, base_thickness+5]) cube([4*main_clearance+2*min_clearance+5*(rs_l+min_clearance), 4*main_clearance+min_clearance, 50]);

  difference() {
    union() {
      hull_box(deck_l,deck_w,base_thickness,1);
      translate([outer_wall+nozzle, outer_wall+nozzle, base_thickness]) hull_box(deck_l-2*(outer_wall+nozzle),deck_w-2*(outer_wall+nozzle), 10, 1);
    }
    union() {
      translate([outer_wall+nozzle-1, 20, base_thickness]) cube([35,81,6]);
    translate([outer_wall+min_clearance+nozzle, outer_wall+min_clearance+nozzle, base_thickness+10]) {
    //translate([0, 0, base_thickness+10]) {

      translate([ 0, 0, -2*nozzle]) victory_rule(deck_l-2*(outer_wall+min_clearance+.5*nozzle));
      translate([0, vr_h, 0]) {
        // City improvements
        translate([4*main_clearance+min_clearance, .5*min_clearance, 0]) {
          for (j = [0:2]) {
            translate([ 0, j*(5+5*nozzle+2*min_clearance), -2*nozzle]) {
              improvements();
            }
          }
          translate([.5*nozzle, 2.5+2.5*nozzle,-10+2*nozzle]) {
            translate([2.5, 0, 0]) %coins();
            translate([2.5, 1*(5+5*nozzle+2*min_clearance), 0]) %cloth();
            translate([2.5, 2*(5+5*nozzle+2*min_clearance), 0]) %books();
          }
        }
        // Settlements, cities, knights and walls
        translate([base_radius+nozzle,base_radius+nozzle,0]) {
          for (j = [0:3]) for (i = [0:3]) {
            translate([i*main_clearance, j*main_clearance, -2*base_thickness-nozzle]) {
              cylinder(r=base_radius+nozzle,h=20);
              %translate([0, 0, 2*nozzle]) if (i<2 && j>0) { knight(j);
              } else { if (j*4+i<7) { settlement(); } else { if (j*4+i==11) { for (t = [0:2]) translate([0,0,t*10]) wall(); } else { city(); } }
              }
            }
          }
        }
        // Roads and ships
        translate([4*main_clearance+min_clearance, 3*main_clearance+2*(base_radius+nozzle) - (6*(rs_w+min_clearance)), 0]) {
          for (z = [0:1]) for (j = [0:2]) for (i = [0:4]) {
            translate([i*(rs_l+min_clearance), ((z*3)+j)*(rs_w+min_clearance)+(z*min_clearance), 0]) {
              translate([0, 0, -10]) cube([rs_l, rs_w, 20]);
              %translate([5, 3, 2*nozzle]) rotate([0,90,90]) if (z==0) { road(); } else { ship(); }
            }
          }
        }
      }
    }}
  }
}
