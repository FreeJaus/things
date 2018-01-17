/*
- The Robber
- Longest Road Special Victory Point card
- Largest Army Special Victory Point card

- Resource card holder
  - https://www.thingiverse.com/thing:399805
  - https://www.thingiverse.com/thing:248348
  - https://www.thingiverse.com/thing:56953
  - https://www.thingiverse.com/thing:164425

# Cities & Knights
- The Barbarian Fleet
- The Merchant
- 3 Metropolis tokens
- Barbarian Invasion Plan
- 6x Defender of Catan Victory Point Cards + 3x for 5-6 expansion

# Seafarers
- 8x Victory Point chits + 6x for 5-6 expansion
- The Pirate
*/

include <c3d_params.scad>;
use <parts/c3d_robber.scad>;
use <parts/cities_knights/c3d_merchant.scad>;
use <parts/cities_knights/c3d_metropoly.scad>;
use <parts/cities_knights/c3d_barbarians.scad>;
use <parts/cities_knights/c3d_barbarian_plan.scad>;
use <parts/markers/c3d_victory_road.scad>;
use <parts/markers/c3d_army.scad>;
use <parts/markers/c3d_chit.scad>;
use <parts/markers/c3d_defender.scad>;
use <parts/seafarers/c3d_pirate.scad>;

//---

translate([55,27,0]) {
  robber();
  translate([18,0,0]) merchant();
  translate([32,0,0]) pirate();
  translate([42,0,0]) barbarians();
}

for (i = [0:2]) translate([50+i*25,6,8.30]) metropoly();

module marker(k) {
  if (k==0) {
    victory_road();
  } else {
    if (k==1) {
      army();
    } else {
      if (k<11) {
        defender();
      } else {
        chit();
      }
    }
  }
}

clearance = 4*nozzle;

for (j = [0:4]) for (i = [0:4]) translate([i*(5+nozzle+2*clearance), j*(5+nozzle+2*clearance), 0]) marker(j*5+i);

//translate([75,50,0]) victory_road();
//translate([75,75,0]) army();
//for (i = [0:13]) translate([75,100+i*25,0]) chit();

//for (i = [0:8]) translate([125,75+i*25,0]) defender();

deck_l = 82.5;
deck_w = 57.5;

module markers(l) {
  translate([ 2.5+4.5*nozzle+2*clearance, 2.5+.5*nozzle+3*clearance, 0]) {
    for (j = [0:4]) for (i = [0:4]) translate([i*(5+nozzle+2*clearance), j*(5+nozzle+2*clearance), -10+clearance]) {
      cylinder(r=2.5+.5*nozzle,h=20);
      %marker(j*5+i);
    }
  }
}

module barbarian_plan(l) {
  translate([ 2.5+4.5*nozzle+2*clearance, 2.5+4.5*nozzle+2*clearance, 0]) {
    %rotate([0,0,-90]) barbarians();
    for (i = [0:7]) translate([i*(5+nozzle+2*clearance), 0, -10+clearance]) cylinder(r=2.5+.5*nozzle,h=20);
  }
}

module common_deck_top() {
  difference() {
    hull_box(deck_l,deck_w, 40+base_thickness,1);
    translate([outer_wall+nozzle, outer_wall+nozzle, base_thickness]) hull_box(deck_l-2*outer_wall,deck_w-2*outer_wall, 50, 1);
  }
}

module base_robber() {
  %robber();
}

module base_merchant() {
  %merchant();
}

module base_pirate() {
  %pirate();
}

module common_deck() {
  //#translate([outer_wall+nozzle, outer_wall+nozzle, base_thickness+5]) cube([4*main_clearance+2*min_clearance+5*(rs_l+min_clearance), 4*main_clearance+min_clearance, 50]);

  difference() {
    union() {
      hull_box(deck_l,deck_w,base_thickness,1);
      translate([outer_wall+nozzle, outer_wall+nozzle, base_thickness]) hull_box(deck_l-2*(outer_wall+nozzle),deck_w-2*(outer_wall+nozzle), 10, 1);
    }
    //translate([outer_wall+min_clearance+nozzle, outer_wall+min_clearance+nozzle, base_thickness+10]) {
    translate([0, 0, base_thickness+10]) {
      translate([5*(5+nozzle+2*clearance)+2*clearance+base_radius, 5+nozzle+5*clearance+base_radius,0]) {
        base_robber();
        %for (i = [0:2]) translate([0,20,8.30+i*10]) metropoly();
        translate([ base_radius+4*clearance, 20, 0]) base_merchant();
        translate([ base_radius+4*clearance, 0, 0]) base_pirate();
      }
      translate([ 0, 5+nozzle+2*clearance, -2*nozzle]) markers(deck_l-2*(outer_wall+min_clearance+.5*nozzle));
      translate([ 0, 0, -10+2*nozzle]) barbarian_plan(deck_l-2*(outer_wall+min_clearance+.5*nozzle));
    }
  }
}

translate([0,-75,0])  common_deck();
