use <path_extrude.scad>;
include <icestick.scad>

$fn=144;

nozzle = 0.4;

border_radius = 2;

wall_inner = 3*nozzle;
wall_outer = 4*nozzle;
wall_height = 6;

base_thickness = 4*nozzle;

slot_offset = 2;

//---

poly_points = [
  [0,pcb_cut_w],
  [pcb_cut_l,0],
  [pcb_l,0],
  [pcb_l,pcb_w],
  [pcb_cut_l,pcb_w],
  [0,pcb_w-pcb_cut_w]
];

function offset_points(w,c) = [
  [-w+c,-w*tan(atan(pcb_cut_l/pcb_cut_w)/2)],
  [-w*tan((90-atan(pcb_cut_l/pcb_cut_w))/2),-w],
  [w,-w],
  [w,w],
  [-w*tan((90-atan(pcb_cut_l/pcb_cut_w))/2),w],
  [-w+c,w*tan(atan(pcb_cut_l/pcb_cut_w)/2)]
];

module base(d,h,c) {
  offsets = offset_points(d,c);
  linear_extrude(h)
    polygon(points=[ for (i = [0 : 1 : len(poly_points) - 1]) poly_points[i]+offsets[i] ]);
}

module hull_base(w,r,h,c) {
  offsets = offset_points(w-r,c);
  linear_extrude(h)
    hull()
      for (i = [0 : 1 : len(poly_points) - 1]) translate(poly_points[i]+offsets[i]) circle(r);
}
/*
    translate([1.85,pcb_cut_w,0]){
      circle(r);
    }
    translate([pcb_cut_l,0,0]){
      circle(r);
    }
    translate([pcb_l,0,0]){
      circle(r);
    }
    translate([pcb_l,pcb_w,0]){
      circle(r);
    }
    translate([pcb_cut_l,pcb_w,0]){
      circle(r);
    }
    translate([1.85,pcb_w-pcb_cut_w,0]){
      circle(r);
    }
*/

module wall(o,i,h) {
  difference(){
    hull_base(o,.25*border_radius,h,0);
    translate([0,0,-h/2]) base(i,2*h,0);
  }
}

module hull_wall(w,o,i,h) {
  difference(){
    hull_base(0,o,h,0);
    translate([0,0,-h/2]) hull_base(0,i,2*h,0);
  }
}

module hull_cylinder() {
  hull() {
    cylinder(r=2+.5*nozzle,h=8);
    translate([-2,0,0]) cylinder(r=2+.5*nozzle,h=8);
  }
}

module ir_hole(z) {
  translate([88,10,z]){
    rotate([0,90,0]){
      hull() {
        hull_cylinder();
        translate([0,6,0]) hull_cylinder();
      }
    }
  }
}

module chamfer(d) {
  offsets = offset_points(d,0);
  z=2.5*nozzle;
  translate([0,0,z])
  path_extrude(points=[[-z,z,0],[0,0,0],[0,z,0]], path=[
      for (i = [0 : 1 : len(poly_points) - 1])
        [poly_points[i][0]+offsets[i][0],
         poly_points[i][1]+offsets[i][1],
         0] ]);
}

module bottom() {
  hull_base(1.5*nozzle+wall_inner+wall_outer, border_radius, base_thickness, wall_inner);
  difference(){
    union(){
      // Inner wall
      translate([0,0,base_thickness]) {
        wall(nozzle+wall_inner,nozzle,wall_height);
        chamfer(nozzle);
      }
      // Smooth front
      difference(){
        difference(){
          hull_base(1.5*nozzle+wall_inner+wall_outer, border_radius, base_thickness+wall_height, wall_inner);
          base(nozzle, 2*(base_thickness+wall_height+2), 0);
        }
        translate([pcb_cut_l+slot_offset,-1.5*nozzle+wall_inner+wall_outer-10,-5])
          cube([pcb_l+1.5*nozzle+wall_inner+wall_outer+20,pcb_w+1.5*nozzle+wall_inner+wall_outer+20,2*base_thickness+wall_height+10]);
      }
    }
    union() {
      ir_hole(7);
      // USB
      translate([-3.5,6.75,2]) cube([4.5,12.5,10]);
    }
  }
}

module led_seps(h) {
  translate([71,13,base_thickness-h/2]){
    translate([0,2.5,0])   cube([8,4*nozzle,h],true);
    translate([0,-2.5,0])  cube([8,4*nozzle,h],true);
    translate([1.25,0,0])  cube([2*nozzle,12.5,h],true);
    translate([-1.25,0,0]) cube([2*nozzle,12.5,h],true);
  }
}

module led_holes() {
  module led() {
    cylinder(r=2.5*nozzle,h=4);
  }
  translate([71,13,-1]){
    led();
    translate([2.5,0,0])  led();
    translate([-2.5,0,0]) led();
    translate([0,5,0])    led();
    translate([0,-5,0])   led();
  }
}

module pin_row(h) {
  translate([1.5,1.5,0])
    hull() {
      cylinder(r=1.5,h=h);
      translate([23.5,0,0]) cylinder(r=1.5,h=h);
    }
}

module j2(r,h) {
  translate([.25+r-.75,r-.25,0]) linear_extrude(h){
    hull() {
      translate([0,0,0]) circle(r=r);
      translate([7.5-2*r,0,0]) circle(r=r);
      translate([7.5-2*r,16.5-2*r,0]) circle(r=r);
      translate([0,16.5-2*r,0]) circle(r=r);
    }
  }
}

module top() {
difference() {
union(){
  difference() {
    hull_base(1.5*nozzle+wall_inner+wall_outer, border_radius, base_thickness, wall_inner);
    union() {
      // Pin rows
      translate([62,.5,-1]){
        pin_row(4);
        translate([0,22,0]) pin_row(4);
      }
      // J2
      translate([76,5,-4]) j2(1,16);
      // LEDs
      led_holes();
      // Text
      translate([9.5,7,1.25]) linear_extrude(1.5) text("elide",12,font = "DejaVu Sans Mono:style=Bold");
    }
  }
  translate([0,0,-wall_height]){
    // Outer wall
    difference() {
      difference(){
        hull_base(1.5*nozzle+wall_inner+wall_outer, border_radius, wall_height, wall_inner);
        translate([0,0,-wall_height/2]) base(1.5*nozzle+wall_inner, 2*wall_height, 0);
      }
      union(){
        // Front cut
        translate([-50+pcb_cut_l+slot_offset+.5*nozzle,0,0]) cube([100,100,100],center=true);
        // Thumb notches
        translate([49,0,-20]) rotate([90,0,0]) cylinder(d=50,h=100,center=true);
      }
    }
  }
  led_seps(wall_height-2);
  difference(){
    translate([0,0,-wall_height+4]){
      hull_base(.5*nozzle, .25*border_radius, base_thickness+wall_height-4,0);
      translate([-wall_outer-1.5*nozzle,7.25,1]) cube([10, 11.5, base_thickness+wall_height-5]);
    }
    union() {
      translate([-1.5*nozzle,6.75,-wall_height+3]) cube([10, 12.5, 2]);
      translate([7,-20,-10]) cube([100,50,50]);
    }
  }
}
union() {
  // IR
  ir_hole(-nozzle);
  translate([85-nozzle/2,8-nozzle/2,-.1]) cube([3+nozzle,10+nozzle,10]);
}
}
}
