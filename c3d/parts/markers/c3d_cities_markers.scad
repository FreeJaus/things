include <../../c3d_params.scad>;

module coins_symbol() {
  scale([.20,.3,.20]) import("../../ext/potcc-2-skull-flat-bottom.stl");
}

module coins() {
  cylinder(r=2.5,h=15);
  translate([0,0,15]) cylinder(r1=2.5, r2=1.5, h=5);
  translate([-5,-1,18]) {
    coins_symbol();
  }
}

module cloth_symbol() {
  scale([.085,.085,.085]) import("../../ext/ClothThingHangin.stl");
}

module cloth() {
  cylinder(r=2.5,h=22.40);
  translate([0,0,22.5]) rotate([180,0,0]) {
    cloth_symbol();
  }
}

module books_symbol() {
  scale([.05,.125,.05]) import("../../ext/Openbook.stl");
}

module books() {
  cylinder(r=2.5,h=16.5);
  translate([0,0,16.5]) cylinder(r1=2.5, r2=1.5, h=5);
  translate([0,3,19.5]) rotate([50,0,0]) {
    books_symbol();
  }
}
