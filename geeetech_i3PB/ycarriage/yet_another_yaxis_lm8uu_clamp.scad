$fn=360;

radius=7.55;
length=20;
thickness=3.25;

//%translate([0,19.5,0]) rotate([0,0,270]) import("Y-axis-igus-lm8uu-clamp.stl");

pw=12; //platform_width
ph=4.5; //platform_height
pe=2.25; //platform_exta
R = radius+thickness;
hb = 3;

module base(ir,r,R,h,pw,ph,s,ss) {
    
b = atan((r+pw)/hb);
H = hb/cos(b);
t = asin(R/H);
a = t - (90 - b);
L = R/tan(t);

g = ((270-b)+(270-t));

translate([R,0,0]) difference() {
  union() {
    for (i = [0:1]) {
      f = 1-2*i;
      translate([-hb,-(1-i)*pw-(1-2*i)*r,0]) cube([hb,pw,h]);
      if ( s == true ) {
        translate([-R*sin(g),f*R*cos(g),0])
          rotate([0,0,f*(90-a)])
            translate([0,-10*(f+i),0])
              cube([L,10,h]);
      }
    }
    cylinder(r=r+thickness,h=h);
    translate([0,-pw-r,0]) cube([ph+5,2*(r+pw),h]);
  }
  translate([0,0,-1]) union() {
    cylinder(r=ir,h=h+2);
    translate([R,-50,0]) cube([100,100,h+2]);
    /*
    if ( ss == true ) {
      translate([0,-ir,0]) cube([100,2*ir,h+2]);
    } else {
      translate([0,-5.875,0]) cube([100,11.75,h+2]);
    }
    */
  }
}
}

/*
3
3
1
16
1
3
3
*/

module hex() {
$fn=6;
cylinder(r=3.2,h=9.5);
}

module hole() {
$fn=360;
cylinder(r=1.5,h=100);
}

module unit() {
difference() {
  union() {
    base(4.75,radius,R,2,pw,ph+pe,true,true);
    translate([0,0,2]) base((radius+4.75)/2,radius,R,1,pw,ph+pe,true,true);
    translate([0,0,3]) base(radius,radius,R,3.1,pw,ph+pe,false,false);
    translate([0,0,6.1]) base(radius-.75,radius,R,.8,pw,ph+pe,false,false);
    translate([0,0,6.9]) base(radius,radius,R,16.2,pw,ph+pe,false,false);
    translate([0,0,23.1]) base(radius-.75,radius,R,.8,pw,ph+pe,false,false);
    translate([0,0,23.9]) base(radius,radius,R,3.1,pw,ph+pe,false,false);
    translate([0,0,27]) base((radius+4.75)/2,radius,R,1,pw,ph+pe,true,true);
    translate([0,0,28]) base(4.75,radius,R,2,pw,ph+pe,true,true);
  }
  translate([0,0,15]) rotate([0,90,0]) union() {
    for (i = [0:1]) {
      translate([0,(1-2*i)*15,0]) {
        hex();
        hole();
      }
    }
  }
}
}
/**/
translate([20,0,0]) difference() {
  unit();
  translate([-100+radius+thickness,-50,-5]) cube([100,100,100]);
}

difference() {
  unit();
  translate([radius+thickness-0.0001,-50,-5]) cube([100,100,100]);
}

/**/