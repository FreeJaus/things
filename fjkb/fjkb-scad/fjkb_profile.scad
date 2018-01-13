module bar(s,t,r,p) {
  translate(p) {
    rotate(r) {
      translate(t) {
        square(size=s,center=true);
}}}}

/************************/
/*
t=165;
f=27.5;
w=200;
h=30;
ang=6;
ri=1.5;
*/

module lid(s,e,b,l,t,f,w,h,ang,ri) {
  union() {
    translate([0,0,s*(l+b)/2]) {
      linear_extrude(height=b,center=true) {
        ocontour(e,t,f,w,h,ang,ri);
      }
    }

    linear_extrude(height=b/2+l,center=true) {
      translate([e,e,0]){
        icontour(t,f,w,h,ang,ri);  
      }
    }
  }
}

module profile(e,l,t,f,w,h,ang,ri) {
  difference() {
    linear_extrude(height=l,center=true) {
      ocontour(e,t,f,w,h,ang,ri);
    }

    linear_extrude(height=l+10,center=true) {
      translate([e,e,0]){
        icontour(t,f,w,h,ang,ri);  
      }
    }
  }
}

module ocontour(e,t,f,w,h,ang,ri) {
  icontour(t,f,w+2*e,h+2*e,ang,ri+e);
}

module icontour(t,f,w,h,ang,ri) {

aux_f=acos((h-2*ri)/f);

A=[0,0];
B=[f*sin(aux_f),h-2*ri];
C=[B[0]+t*cos(ang),B[1]-t*sin(ang)];
D=[w-2*ri,0];

P=[A,B,C,D];

aux_r=atan((D[1]-C[1])/(D[0]-C[0]));
r = (D[1]-C[1])/sin(aux_r); //sqrt(pow(a,2)+pow(b,2))

/************************/

translate([ri,ri,0]) {

polygon(P);

for(k=[0:3]) {
  translate([P[k][0],P[k][1],0]) {
    circle(r=ri,center=true);
  } 
}

bar([2*ri,f],[0,f/2,0],[0,0,-aux_f],[0,0,0]);
bar([t,2*ri],[t/2,0,0],[0,0,-ang],[B[0],h-2*ri,0]);
bar([r,2*ri],[r/2,0,0],[0,0,aux_r],[C[0],C[1],0]);
bar([w-2*ri,2*ri],[w/2-ri,0,0],[0,0,0],[0,0,0]);

}

/************************/

a_bf=90-aux_f;
a_tf=90-ang+aux_f;
a_tr=180+aux_r-ang;
a_br=90+aux_r;

echo("a_bf:", a_bf);
echo("a_tf:", a_tf);
echo("a_tr:", a_tr);
echo("a_br:", a_br);

echo("l_r:", r);

}