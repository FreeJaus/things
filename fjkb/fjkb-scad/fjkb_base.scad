module bar(s,t,r,p) {
  translate(p) {
    rotate(r) {
      translate(t) {
        square(size=s,center=true);
}}}}

/************************/

base_w=400;
base_h=150;
base_ang=5;

ri=5;
len_t=base_h;
len_f=30;
len_r=2;
ang_tf=90+base_ang;
ang_tr=80;

A=[0,0];
B=[0,len_f];
C=[len_t*cos(base_ang),len_f-len_t*sin(base_ang)];
D=[C[0]+len_r*cos(base_ang+ang_tr),C[1]-len_r*sin(base_ang+ang_tr)];
P=[A,B,C,D];

//ang_bf=;
//ang_br=;

alpha = atan(D[1]/D[0]);
len_b=D[0]/cos(alpha);

echo(alpha);
echo(alpha+base_ang);
echo(len_b);

rotate([0,0,-alpha]) {

polygon(P);

for(k=[0:3]) {
  translate([P[k][0],P[k][1],0]) {
    circle(r=ri,center=true);
  } 
}
/*
color("red") {
*/
bar([2*ri,len_f],[0,0,0],[0,0,0],[0,len_f/2,0]);
bar([len_t,2*ri],[len_t/2,0,0],[0,0,-base_ang],[0,len_f,0]);
bar([len_r,2*ri],[len_r/2,0,0],[0,0,-(base_ang+ang_tr)],[C[0],C[1],0]);
bar([len_b,2*ri],[len_b/2,0,0],[0,0,alpha],[0,0,0]);
/*}*/
}