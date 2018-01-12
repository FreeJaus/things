/*projection(cut=false) import("icestick_case.stl");
*/
/*
translate([0,100,0]) projection(cut=false) translate([0,0,-2]) import("icestick_case.stl");

translate([0,-100,0]) import("icestick_case.stl");
*/
//ranslate([200,0,0]) projection(cut=true) rotate([0,90,0]) import("icestick_case.stl");
$fn=100;

translate([0,0,20]) rotate([45,45,0]) cylinder(d=2,h=30);

projection(cut = false) rotate([45,45,0]) cylinder(d=2,h=30);

translate([10,10,0]) projection(cut = true) rotate([45,45,0]) cylinder(d=2,h=30);

//translate([0,0,20]) import("icestick_case.stl");

//projection(cut = false) rotate([45,45,0]) import("icestick_case.stl");

projection(cut = true) rotate([45,45,0]) import("icestick_case.stl");