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
- 6x Defender of Catan Victory Point Cards

# Seafarers
- 8 Victory Point chits
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
use <parts/seafarers/c3d_pirate.scad>;

//---

robber();

translate([50,0,0]) merchant();

translate([100,50,0]) barbarians();
translate([100,50,0]) barbarian_plan();

for (i = [0:2]) translate([100,0,0]) metropoly();

translate([100,50,0]) victory_road();
translate([100,50,0]) victory_army();
for (i = [0:7]) translate([100,50,0]) victory_chit();
