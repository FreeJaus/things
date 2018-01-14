include <../../c3d_params.scad>;
include <c3d_knight_flag.scad>;

module level_rows(l) {
  translate([0,0,-(l-1)*2*nozzle])
  for (i = [0:l-1]) {
    translate([0,0,i*4*nozzle]) difference() {
      cylinder(r=10,h=2*nozzle);
      cylinder(r=10-2*nozzle,h=2*nozzle);
    }
  }
  /*
    if (l==1) {
    }
    if (l==2) {
    }
    if (l==3) {
    }*/
}

module knight(l) {

 knight_flag = true;

 r1 = .75*base_radius;
 r2 = .5*base_radius;
 r3 = .7*base_radius;
 r4 = .4*base_radius;
 r5 = .6*base_radius;

 h = 1.5*base_radius;
 h1 = .2;
 h2 = .3;
 h3 = .15;
 h4 = .075;
 h5 = .05;
 h6 = .175;
 h7 = .5;
 h8 = .25;

 cylinder(r=base_radius,h=base_thickness);

 rotate([0,0,-30])
 difference() {
   difference() {
     translate([0,0,0]) cylinder(r=1.25*r1,h=h);
     union() {
       translate([-3,0,0]) cylinder(r=r3+2.75,h=1.5*h);
       translate([0,0,.5*h]) level_rows(l);
     }
   }
   translate([-25,0,0]) cube([50,50,50],center=true);
 }

 translate([0,0,base_thickness]) {
   translate([-r3+1.5*nozzle,0,0]) {
     if(knight_flag==true) {
       translate([0,0,2.75*base_radius-5]) rotate([0,0,-60]) %knight_flag();
     }
     cylinder(r=1.5*nozzle, h=2.75*base_radius);
   }

   cylinder(r1 = r1, r2 = r2, h=h1*h);
    translate([0,0,h1*h]) {
      cylinder(r=r2,h=h2*h);
      translate([0,0,h2*h]) {
        cylinder(r1 = r2, r2 = r3, h=h3*h);
        translate([0,0,h3*h]) {
          cylinder(r=r3,h=h4*h);
          translate([0,0,h4*h]) {
            cylinder(r=r4,h=h5*h);
            translate([0,0,h5*h]) {
              cylinder(r1 = r4, r2 = r5, h=h6*h);
              translate([0,0,h6*h]) difference() {
                cylinder(r = r5, h=h7*h);
                union() {
                  translate([2*nozzle,-r5,.5*h7*h]) cube([10,2.5,2*nozzle]);
                  translate([-10-2*nozzle,-r5,.5*h7*h]) cube([10,2.5,2*nozzle]);
                }
                }
            }
          }
        }
      }
    }
  }

  translate([0,0,base_thickness+(h1+h2+h3+h4+h5+h6+h7)*h]) {
    if (l==1) {
      cylinder(r1 = r5, r2 = 0, h=h8*h);
    }
    if (l==2) {
      translate([2,0,0]) cylinder(r1 = r5-2, r2 = 0, h=h8*h);
      translate([-2,0,0]) cylinder(r1 = r5-2, r2 = 0, h=h8*h);
    }
    if (l==3) {
      rotate([0,0,-90]) translate([2,0,0]) cylinder(r1 = r5-2, r2 = 0, h=h8*h);
      rotate([0,0,150]) translate([2,0,0]) cylinder(r1 = r5-2, r2 = 0, h=h8*h);
      rotate([0,0,30]) translate([2,0,0]) cylinder(r1 = r5-2, r2 = 0, h=h8*h);
    }
  }
}
