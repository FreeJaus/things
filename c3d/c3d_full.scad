$fn=100;
T=0.1; //Tolerance
TBR=25; //Tile radius/length of the sides
TB=1; //Tile base height
TH=1; //Tile resource height
NR=5+T; //Number radius
NH=1-T; //Number height
PR=4+T; //Piece radius
RH=10; //Road length
RW=2.5; //Road width (recommendeed >2*TH)
UW=2; //Union width

module hex_r(r, h) {
 b=60; d=2*r*sin(b);
 translate([0,0,h/2]) {
  for (t = [-b, 0, b]) rotate([0,0,t]) cube([r, d, h], true);
 }
}

module tile(nonum) {
 module cyl_sub(nonum) {
  if(!nonum) { translate([0,0,TH-NH]) cylinder(h=1.5*NH,r=NR); }
  for (t = [0:1:5]) {
   rotate([0,0,60*t]) translate([TBR,0,0]) cylinder(h=1.5*TH,r=PR);
   put_road(1+t) 
   union() {
    road(RW+2*T,RH+2*T);
    translate([0,-TH/2,TH/2])
    rotate([0,90,0]) difference() {
     cube([1.45*TH,1.45*TH,1.45*TBR],center=true);
     union() {
      translate([0,-1.5*TH/2,0])
       cube([1.5*TH,1.5*TH,1.5*TBR],center=true);
      translate([1.55*TH/2,0,0])
       cube([1.55*TH,1.55*TH,1.55*TBR],center=true);
      cylinder(h=1.6*TBR,r=TH/2,center=true);
     }
    }
   }
   translate([0,0,-TB-.25*(TB+TH)])
   put_road(1+t)
   linear_extrude(1.5*(TB+TH)){
    polygon([[-T/2,0],[-T/2,-T-RW/2],[T+RH/2,-T-RW/2],[-UW+RH/2+T,0],[-UW+RH/2+T,.5],[-T/2,.5]]);
   }
  }
 }
render() {
 difference() {
  union() {
   hex_r(TBR,TB+TH);
   for (t = [0:1:5]) {
    put_road(1+t)
    linear_extrude(TB){
     polygon([[-T/2,0],[-T/2,-RW/2],[UW-RH/2,-RW/2],[UW-RH/2,0],[T-RH/2,RW/2],[-T/2,RW/2]]);
    }
   }
  }
  translate([0,0,TB]) cyl_sub(nonum);
 }
}
}

module road(w,h,circ) {
 translate([0,0,w/2])
 if(!circ) { cube([h,w,w],center=true); }
 else { rotate([0,90,0]) cylinder(h=h,r=w/2,center=true); }
}

module put_road(p) {
 deg=[-60,0,60,120,180,-120];
 x=[1,0,-1,-1,0,1];
 y=[TBR/2,TBR,TBR/2,-TBR/2,-TBR,-TBR/2];
 for(k=p) {
  translate([x[k-1]*cos(30)*TBR*cos(30),y[k-1]*cos(30),0])
  rotate([0,0,deg[k-1]]) children();
 }
}

module put_tile(i,j,nonum) {
 translate([1.5*TBR*i,-TBR*sin(60)*j,0]) children();//tile(nonum);
}

module house(r1,h1,r2,h2) {
 cylinder(h=h1,r=r1);
 translate([0,0,h1-T]) cylinder(h=h2,r1=r2,r2=0);
}

module toshow(good) {
 if (to) {tile();} else {hex_r(TBR,TB+TH);}
}

to=true;

put_tile(0,0) toshow(to);
put_tile(1.5,1.5) toshow(to);

for (k=[0:1:2]) {
 color("LightGrey") put_tile(k+2,k) toshow(to);
 color("Goldenrod") put_tile(k+1,1+k) toshow(to);
 color("LightBlue") put_tile(k,2+k) toshow(to);
 color("LightSalmon") put_tile(k,4+k) toshow(to);
 color("LimeGreen") put_tile(k,6+k) toshow(to);
}
color("Goldenrod") put_tile(4,4) toshow(to);
color("LightSalmon") put_tile(3,7) toshow(to);
color("LightBlue") {
 put_tile(4,6) toshow(to);
 put_tile(3,5) toshow(to);
}

color("DodgerBlue") {
 put_tile(0,4) {
  translate([TBR,0,0]) house(PR,1.5*PR,1.25*PR,PR);
 }
 put_tile(1,5) {
  rotate([0,0,-120]) translate([TBR,0,0]) house(PR,1.5*PR,1.25*PR,PR);
  translate([TBR,0,0]) house(PR,1.5*PR,1.25*PR,PR);
  translate([0,0,TB]){ put_road([3,4,5,6]) road(RW,RH); }
 }
}

color("OrangeRed") {
 put_tile(2,4) {
  translate([TBR,0,0]) house(PR,1.5*PR,1.25*PR,PR);
  translate([0,0,TB]){ put_road([1,2,3]) road(RW,RH); }
 }
 put_tile(1,3) {
  translate([TBR,0,0]) house(PR,1.5*PR,1.25*PR,PR);
 }
}