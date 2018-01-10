include <icestick.scad>

//$fn=144;

module layout(c,h) {
  linear_extrude(h){
    polygon(points=[
      [-c,pcb_cut_w-c/2],
      [pcb_cut_l-c/4,-c],
      [pcb_l+c,-c],
      [pcb_l+c,pcb_w+c],
      [pcb_cut_l-c/4,pcb_w+c],
      [-c,pcb_w-pcb_cut_w+c/2]
    ]);
  }
}

module hull_layout(c,h) {
  linear_extrude(h){
  hull() {
    translate([1.85,pcb_cut_w,0]){
      circle(c);
    }
    translate([pcb_cut_l,0,0]){
      circle(c);
    }
    translate([pcb_l,0,0]){
      circle(c);
    }
    translate([pcb_l,pcb_w,0]){
      circle(c);
    }
    translate([pcb_cut_l,pcb_w,0]){
      circle(c);
    }
    translate([1.85,pcb_w-pcb_cut_w,0]){
      circle(c);
    }
  }}
}

module wall(o,i,h) {
  difference(){
    layout(o,h);
    translate([0,0,-h/2]){
      layout(i,2*h);
    }
  }
}

module hull_wall(o,i,h) {
  difference(){
    hull_layout(o,h);
    translate([0,0,-h/2]){
      hull_layout(i,2*h);
    }
  }
}

module ir_hole(z) {
  translate([88,9.5,z]){
    rotate([0,90,0]){
      //hull() {
        cylinder(r=2,h=8);
        translate([0,7,0]){
          cylinder(r=2,h=8);
        }
      //}
    }
  }
}

module bottom() {
union(){
  hull_layout(4,2);
  difference(){
    union(){
    translate([0,0,2]){
      wall(2,.5,8);
    }
      difference(){
    difference(){
      hull_layout(4,10);
      layout(.5,12);
    }
    translate([pcb_cut_l+2,-20,-10]){
      cube([100,50,50]);
    }
  }
  }
    union() {
      ir_hole(7);
      translate([-3.5,6.5,2]){
        cube([4.5,13,10]);
      }
    }
  }

}
}

module led_seps() {
  translate([71,13,-1]){
    translate([0,2.5,0]){cube([8,2,6],true);}
    translate([0,-2.5,0]){cube([8,2,6],true);}
    translate([1.25,0,0]){cube([.7,12.5,6],true);}
    translate([-1.25,0,0]){cube([.7,12.5,6],true);}
  }
}

module led_holes() {
  module led() {
    cylinder(r=.85,h=4);
  }
  translate([71,13,-1]){
    led();
    translate([2.5,0,0]){led();}
    translate([-2.5,0,0]){led();}
    translate([0,5,0]){led();}
    translate([0,-5,0]){led();}
  }
}

module top() {
union(){
  difference() {
    hull_layout(4,2);
    union() {
      // Pin rows
      translate([62,.5,-1]){
        cube([26.5,3,4]);
        translate([0,22,0]){
          cube([26.5,3,4]);
        }
      }
      // J2
      translate([76,5,-4]){
        difference(){
          cube([6,16,16]);
        }
      }
      // LEDs
      led_holes();
      translate([5.5,7,1.25]){
        linear_extrude(1.5){
         text("elide",12,"DejaVu Sans Mono");
        }
      }
    }
  }
  translate([0,0,-8]){
    difference() {
      difference(){
        hull_layout(4,8);
        layout(2,8);
      }
      union(){
        // IR
        ir_hole(5);
        translate([-pcb_cut_l+6,-20,-10]){
          cube([pcb_cut_l+5,50,50]);
        }
        translate([49,0,-20]){
          rotate([90,0,0]){
            cylinder(d=50,h=100,center=true);
          }
        }
      }
    }
  }
  led_seps();
  difference(){
    translate([0,0,-3]){
      layout(.5,3);
      translate([-2.125,6.5,0]){
        cube([10,13,3]);
      }
    }
    translate([7,-20,-10]){
      cube([100,50,50]);
    }
  }
}
}

/*
color("red"){
  translate([0,0,-3]){
    bottom();
  }
  translate([0,0,27]){
    top();
  }
}

icestick();
*/

translate([0,-50,]){
  bottom();
}

/*
rotate([180,0,0]){
  translate([0,65,-2]){
    top();
  }
}
*/
