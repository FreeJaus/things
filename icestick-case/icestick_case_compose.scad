include <icestick.scad>
include <icestick_case.scad>

/*
color("red")  translate([0,0,-3]) bottom();
color("blue") translate([0,0,wall_height-base_thickness+10*$t]) top();

icestick();
*/

translate([0,-50,]){
  bottom();
}

rotate([180,0,0]){
  translate([0,65,-2]){
    top();
  }
}
