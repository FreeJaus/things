base = 50 + 1;
thickness=5;

translate([0,0,50]) %cube([base,base,200]);
%cube([550,550,50]);

translate([0,0,20]) difference(){
  union() {
    translate([-thickness,-thickness,0]) cube([base+2*thickness,base+2*thickness,75]);
    translate([0,0,30]) cube([base+25,base+25,thickness]);
    translate([base,-thickness,0]) cube([25,thickness,30+thickness]);
    translate([-thickness,base,0]) cube([thickness,25,30+thickness]);
  }
  union() {
    translate([0,0,-.5*base]) cube([base,base,3*base]);
    translate([0,0,-1]) cube([4*base,4*base,31]);
  }
}

