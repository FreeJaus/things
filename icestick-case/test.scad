include <icestick.scad>

$fn=360;

module hull_layout(c,h) {
//hull() {
    translate([1.85,pcb_cut_w,0]){
      circle(c);
    }
    translate([pcb_cut_l,0,0]){
      circle(c);
    }
    /*
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
    }*/
  //  }
}

hull_layout(2,5);
