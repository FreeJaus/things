include <ext/CommonHotendLibrary.scad>
include <ext/ISOthread.scad>

move_x=0;
move_y=0;
move_z=0;

prnt_x=200;
prnt_y=200;
prnt_z=100;
prnt_mar_z=10;
thick=12;

bar_d=15;
bar_x_dist=80;

lin_h=25;
lin_d1=15;
lin_d2=20;

rad_h=10;
rad_d1=15;
rad_d2=20;

mill=1;

car_x_x=75;

base_yh=max(lin_d2,rad_d2)+2*thick;
base_zw=100;

base_z=base_yh+prnt_z+bar_x_dist+bar_d+thick+prnt_mar_z;
base_x=300;
base_y=350;

module bear(d1,d2,h) {
  //difference() {
    cylinder(h=h,d=d2);
    translate([0,0,-5]){cylinder(h=h+10,d=d1);}
  //}
}

//bear(rad_d1,rad_d2,rad_h);

module bear_group(dist,length){
  color("blue"){
  translate([dist/2,length/2-lin_h/2,0]){rotate([-90,0,0]){bear(lin_d1,lin_d2,lin_h);}}
  translate([dist/2,-length/2-lin_h/2,0]){rotate([-90,0,0]){bear(lin_d1,lin_d2,lin_h);}}
  translate([-dist/2,length/2-lin_h/2,0]){rotate([-90,0,0]){bear(lin_d1,lin_d2,lin_h);}}
  translate([-dist/2,-length/2-lin_h/2,0]){rotate([-90,0,0]){bear(lin_d1,lin_d2,lin_h);}}
  }
}

module car_x_hotend(){
  translate([0,25,0]){%cube([45,50,45],center=true);}
  translate([0,0,0]){rotate([-90,0,0]){import("Bowden_carriage.stl");}}
  translate([0,50,-1.5]){rotate([-90,0,180]){import("Bowden_carriage_clamp.stl");}}
  translate([0,38.5,4.5]){
    rotate([0,180,0]){E3D175V6Assembly(liteVersion=true, transparency=1);}
  }
}

module car_x(x,z) {
  translate([0,lin_d2/2+thick,-(bar_x_dist+lin_d2+thick/2)/2]){
    rotate([90,0,0]){
      color("red"){
      cube([x,z,thick]);}
      translate([x/2,z/2,-lin_d2/2]){
        bear_group(x-lin_d2,bar_x_dist);
        translate([0,0,thick+lin_d2]){rotate([0,0,90]){bear_group(bar_x_dist,x-lin_h);}}
      }
    }
    translate([0,0,move_z]){
      translate([x/2,lin_d2/2,z/2]){
        rotate([90,0,0]){axis(bar_d,z+100,(x-lin_d2)/2);}
    }

      translate([x/2,lin_d2,-46.5]){car_x_hotend();}

      color("green"){
        translate([0,0,-50]){ cube([x,rad_d2,thick]); }
        translate([0,-thick-2*lin_d2,z]){ cube([x,thick+2*lin_d2+rad_d2,thick]); }
    }}
  }
}

module car_y(dist) {
  translate([0,0,thick/2]){cube([prnt_x,prnt_y,thick],center=true);}
  translate([0,0,-lin_d2/2]){bear_group(dist,prnt_y/4);}
}

module side() {
  cube([base_yh,base_y,thick],center=false);
  cube([base_z,base_zw,thick],center=false);
}

module front() {
  difference(){
  cube([base_x-2*thick,base_yh,thick],center=false);
  union(){
  translate([base_x/2-thick,base_yh-thick-lin_d2/2,-thick/2]){
    cylinder(h=2*thick,d=rad_d2);
    translate([prnt_x/4,0,0]){cylinder(h=2*thick,d=rad_d2);}
    translate([-prnt_x/4,0,0]){cylinder(h=2*thick,d=rad_d2);}
  }}}
}

module back() {
  difference(){
  cube([base_x-2*thick,base_z,thick],center=false);
  union(){
    translate([thick,base_yh-thick,-thick]){  cube([base_x-4*thick,prnt_z+thick,3*thick],center=false);};
    translate([base_x/2-thick,base_yh-thick-lin_d2/2,-thick/2]){
      cylinder(h=2*thick,d=rad_d2);
      translate([prnt_x/4,0,0]){cylinder(h=2*thick,d=rad_d2);}
      translate([-prnt_x/4,0,0]){cylinder(h=2*thick,d=rad_d2);}
  }}
  }
}

module axis(diam,length,dist) {
  translate([dist,-length/2,0]){rotate([-90,0,0]){cylinder(h=length,d=diam);}}
  translate([-dist,-length/2,0]){rotate([-90,0,0]){cylinder(h=length,d=diam);}}
}

module rodaxis(diam,length,dist) {
  translate([dist,-length/2,0]){rotate([-90,0,0]){cylinder(h=length,d=diam);}}
  translate([-dist,-length/2,0]){rotate([-90,0,0]){cylinder(h=length,d=diam);}}
  translate([0,-length/2,0]){rotate([-90,0,0]){
    cylinder(h=length,d=diam*0.9);
    thread_out(diam*0.1,length);
    }}
}

module mounted() {
  translate([0,-base_y/2,0]){
    translate([base_x/2,0,0]){
      rotate([0,-90,0]){ side(); }
    }
    translate([-base_x/2+thick,0,0]){
      rotate([0,-90,0]){ side(); }
    }
  }

  translate([-base_x/2+thick,base_y/2,0]){
    rotate([90,0,0]){ front(); }
  }

  translate([-base_x/2+thick,-base_y/2+thick,0]){
    rotate([90,0,0]){ back(); }
  }
  
   translate([0,-base_y/2+prnt_y/2+thick,prnt_z/2+base_yh]){
    %cube([prnt_x,prnt_y,prnt_z],center=true);
  }
  
  translate([0,0,base_yh-thick-lin_d2/2]){rodaxis(bar_d,base_y,prnt_x/4);}
  
  translate([0,-base_y/2+base_zw/2+thick,base_z-thick-bar_x_dist/2-bar_d/2]){
    rotate([0,90,90]){rodaxis(bar_d,base_x,bar_x_dist/2);}}

  translate([0,-base_y/2+base_zw/2+thick,base_z-thick-bar_x_dist/2-bar_d/2]){car_x(car_x_x,bar_x_dist+lin_d2+thick/2);}

  translate([0,-base_y/2+prnt_y/2+thick,base_yh-thick]){car_y(prnt_x/2);}
}

module plain() {
  side();
  translate([base_z+base_yh+mill,base_y,0]){ rotate([0,0,180]){ side(); } }
  translate([base_z+base_yh+2*mill,base_z+mill,0]){ front(); }
  translate([base_z+base_yh+2*mill,0,0]){ back(); }
}

///

//plain();

translate([-base_x,0,0]) {
  translate([0,0,base_z/2]){
  //  %cube([base_x,base_y,base_z],center=true);
  }
  mounted();
}

/*translate([prnt_x/2,0,100]){
  cube([50,20,100],center=true);
}
*/