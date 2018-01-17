include <../../c3d_params.scad>;

module victory_symbol() {
  scale([.1,.1,.1]) import("../../ext/Trophy_cup_for_Dice.stl");
}

module victory() {
 cylinder(r=2.5,h=17.55);
 translate([0,0,15]) {
   difference() {
     translate([-10.125,-10,0]) victory_symbol();
      translate([0,0,-18]) cylinder(r=5,h=20);
  }
 }
}
