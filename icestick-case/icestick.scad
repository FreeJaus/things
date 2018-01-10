pcb_l = 89;
pcb_w = 26;
pcb_cut_w = 5;
pcb_cut_l = 9;

module icestick() {

  module pin10() {
   color("white"){
     difference(){
       cube([26.5,3,.125]);
       translate([0.125,0.125,-.25]){
         cube([26.25,2.75,.75]);
       }
     }
   }
   for (i = [0:9]) {
     translate([0.55+2.54*i,.23,0]){
      color("DodgerBlue"){
        cube([2.54,2.54,2.54]);
      }
      color("Gainsboro"){
        translate([.87,.87,-3]){
          cube([.8,.8,11]);
        }
      }
     }
   }
  }

  module leds() {
   module led() {
     cube([1,1.25,.25],center=true);
   }
   led();
   translate([2.5,0,0]){led();}
   translate([-2.5,0,0]){led();}
   translate([0,5,0]){led();}
   translate([0,-5,0]){led();}
  }

  // PCB
  color("DarkGreen"){
    linear_extrude(2){
      polygon(points=[[0,pcb_cut_w],[pcb_cut_l,0],[pcb_l,0],[pcb_l,pcb_w],[pcb_cut_l,pcb_w],[0,pcb_w-pcb_cut_w]]);
    }
  }

  // USB
  color("Gainsboro"){
    translate([-15,7,-1]){
      cube([19,12,4.5]);
    }
  }

  // ICs
  color("DimGray"){
    translate([40,3,2]){
      cube([20,20,1]);
    }
    translate([10,7,2]){
      cube([10, 10,.5]);
    }
    translate([18,20,2]){
      cube([4, 5,.5]);
    }
    translate([26,10,2]){
      cube([5, 4,.5]);
    }
    translate([24,1,2]){
      cube([4.5,7,.5]);
    }
  }

  // IR
  translate([86,8,2]){
    color("DimGray"){
      cube([3,10,4]);
    }
    color("DarkSlateGray"){
      translate([3,1.5,2]){
        sphere(1.5);
      }
      translate([3,8.5,2]){
        sphere(1.5);
      }
    }
  }

  // LEDs
  color("GreenYellow"){
    translate([71,13,2]){
      leds();
    }
  }

  // Pin rows
  translate([62,.5,2]){
    pin10();
    translate([0,22,0]){
      pin10();
    }
  }

  // J2
  color("DimGray"){
    translate([76,5,2]){
      difference(){
        cube([6,16,8]);
        for (i = [0:1]) {
          for (j = [0:5]) {
            color("Gainsboro"){
              translate([1.25+i*3,1+j*2.6,2]){
                cube([1,1,11]);
              }
            }
          }
        }
      }
    }
  }

}
