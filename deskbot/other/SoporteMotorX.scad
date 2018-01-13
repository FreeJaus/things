$fn=50;

Base_X=350;
Base_Y=350;
Base_Z=350;

viewmar=0;

Z_lift=160+3*viewmar;
X_axis_sep=50;
Z_axis_HT_sep=15;
Z_axis_MT_sep=30;

Motor_A=42.3;
Motor_H=Motor_A;
Motor_L=68;
Motor_M_L=16;
Motor_M_D=3;
Motor_M_hl=4.5;
Motor_M_HL=2;
Motor_M_HD=5.5;
Motor_ME_A=31;
Motor_ME_H=Motor_ME_A;
Motor_E_L=24;
Motor_E_D=5;
Acop_L=15;
Acop_D=12;
Acop_I_LD=5;
Acop_I_LL=5;
Acop_I_RD=8;
Acop_I_RL=10;
Tubo_H_L=330;
Tubo_H_D=8;
Husi_H_L=350;
Husi_H_D=8;
Tubo_V_L=250;
Tubo_V_D=10;
Husi_V_L=250;
Husi_V_D=10;
P1_A=Motor_A;
P1_H=Motor_H;
P1_L=Motor_M_L;
P2_L=Tubo_V_D+Husi_V_D+10;
P2_D=Acop_D+10;
P3_A=Motor_A;
P3_H=Motor_H;
P3_L=15;

Tuerca_V_L=18;
Tuerca_V_D=19;
//Tuerca_V_l=10;
//Tuerca_V_d=20;

RodLin_V_L=29;
RodLin_V_D=19;
RodLin_H_L=24;
RodLin_H_D=15;

Cojin_H_L=5;
Cojin_H_D=15;


module CojinH() {
  difference() {
  cylinder(h=Cojin_H_L,d=Cojin_H_D);
  translate([0,0,-1]) { cylinder(h=Cojin_H_L+2,d=Tubo_H_D); }
  }
}

module TuercaV() {
  difference() {
  //union() {
  //  cylinder(h=Tuerca_V_L,d=Tuerca_V_d);
  //  cylinder(h=Tuerca_V_l,d=Tuerca_V_D);
  //}
  linear_extrude(Tuerca_V_L) { circle(Tuerca_V_D,$fn=6); }
  translate([0,0,-1]) { cylinder(h=Tuerca_V_L+2,d=Husi_H_D); }
  } 
}

module  RodLinH() {
  difference() {
  cylinder(h=RodLin_H_L,d=RodLin_H_D);
  translate([0,0,-1]) { cylinder(h=RodLin_H_L+2,d=Tubo_H_D); }
  }
}

module  RodLinV() {
  difference() {
  cylinder(h=RodLin_V_L,d=RodLin_V_D);
  translate([0,0,-1]) { cylinder(h=RodLin_V_L+2,d=Tubo_V_D); }
  }
}

module Motor_M(){
cylinder(h=Motor_M_L,d=Motor_M_D);
translate([0,0,Motor_M_L]){cylinder(h=Motor_M_HL,d=Motor_M_HD);}
}

module Motor(){
union(); {
difference(){
translate([0,0,Motor_L/2]){cube([Motor_A,Motor_H,Motor_L],center=true);}

translate([0,0,Motor_L-Motor_M_hl]){
  translate([Motor_E_L/2,Motor_E_L/2,0]){cylinder(h=Motor_M_hl+1,d=Motor_M_D);}
  translate([-Motor_E_L/2,Motor_E_L/2,0]){cylinder(h=Motor_M_hl+1,d=Motor_M_D);}
  translate([Motor_E_L/2,-Motor_E_L/2,0]){cylinder(h=Motor_M_hl+1,d=Motor_M_D);}
  translate([-Motor_E_L/2,-Motor_E_L/2,0]){cylinder(h=Motor_M_hl+1,d=Motor_M_D);}
}
}

translate([0,0,Motor_L-1]) {
  cylinder(h=Motor_E_L+1,d=Motor_E_D);
}
}

translate([0,0,Motor_L+viewmar-Motor_M_hl]){
  translate([Motor_E_L/2,Motor_E_L/2,0]){Motor_M();}
  translate([-Motor_E_L/2,Motor_E_L/2,0]){Motor_M();}
  translate([Motor_E_L/2,-Motor_E_L/2,0]){Motor_M();}
  translate([-Motor_E_L/2,-Motor_E_L/2,0]){Motor_M();}
}
}

module acoplador(){
  difference() {
  cylinder(h=Acop_L,d=Acop_D);
  translate([0,0,Acop_L-Acop_I_RL]) { cylinder(h=Acop_I_RL+1,d=Acop_I_RD); }
  translate([0,0,-1]) { cylinder(h=Acop_I_LL+1,d=Acop_I_LD); }
  }
}

// Motor ZL
translate([Base_X/2,0,0]){
  Motor();
  translate([0,0,Motor_L+Motor_E_L-Acop_I_LL+viewmar]) { acoplador(); }
  translate([0,0,Motor_L+Motor_E_L+Acop_L-Acop_I_LL+2*viewmar]) { cylinder(h=Husi_V_L,d=Husi_V_D); }
  translate([0,0,Z_lift]) { TuercaV(); }
}

// Motor ZR
translate([-Base_X/2,0,0]){
  Motor();
  translate([0,0,Motor_L+Motor_E_L-Acop_I_LL+viewmar]) { acoplador(); }
  translate([0,0,Motor_L+Motor_E_L+Acop_L-Acop_I_LL+2*viewmar]) { cylinder(h=Husi_H_L,d=Husi_H_D); }
  translate([0,0,Z_lift]) { TuercaV(); }
}

// Motor Y
translate([0,0,-200]){
rotate([90,0,0]) { translate([0,0,0]){
  Motor();
  translate([0,0,Motor_L+Motor_E_L-Acop_I_LL+viewmar]) { acoplador(); }
  translate([0,0,Motor_L+Motor_E_L+Acop_L-Acop_I_LL+2*viewmar]) { cylinder(h=Husi_H_L,d=Husi_H_D); }
}}}

// Motor X
translate([-Motor_L-Motor_E_L-Acop_L+Acop_I_RL-Husi_H_L/2,Z_axis_MT_sep,Z_lift]) { 
rotate([0,90,0]){
  Motor();
  translate([0,0,Motor_L+Motor_E_L-Acop_I_LL+viewmar]) { acoplador(); }
  translate([0,0,Motor_L+Motor_E_L+Acop_L-Acop_I_LL+2*viewmar]) { cylinder(h=Husi_H_L,d=Husi_H_D); }
}}
  
module Xaxis() {
translate([Tubo_H_L/2, Z_axis_MT_sep , 0]) {
  rotate([0,-90,0]) {
    translate([X_axis_sep/2,0,0]){
      cylinder(h=Tubo_H_L,d=Tubo_H_D);
      translate([0,0,2-viewmar]) { CojinH(); }
      translate([0,0,viewmar+Tubo_H_L-Cojin_H_L-2]) { CojinH(); }
      translate([0,0,Tubo_H_L/2-RodLin_H_L/2]) { RodLinH(); }
      
    }
    translate([-X_axis_sep/2,0,0]){
      cylinder(h=Tubo_H_L,d=Tubo_H_D);
      translate([0,0,2-viewmar]) { CojinH(); }
      translate([0,0,viewmar+Tubo_H_L-Cojin_H_L-2]) { CojinH(); }
      translate([0,0,Tubo_H_L/2-RodLin_H_L/2]) { RodLinH(); }
    }
  }
}
}

union() {

//RodLinH();

//translate([Motor_L+Motor_E_L/2,Motor_H/2,0])
//cylinder(Motor_E_L,Motor_E_D/2,center=true);  

// Tubos Z

translate([Base_X/2+Z_axis_HT_sep,0,Motor_L]){
  cylinder(h=Tubo_V_L,d=Tubo_V_D);
  translate([0,0,Z_lift-Motor_L]) { RodLinV(); }
}
translate([-Base_X/2-Z_axis_HT_sep,0,Motor_L]){
  cylinder(h=Husi_V_L,d=Husi_V_D);
  translate([0,0,Z_lift-Motor_L]) { RodLinV(); }
}


// Plano base XZ

color("blue"){
translate([-Base_X/2,50,0]){cube([Base_X,1,Base_Z]);}
}

//

translate([0,0,Z_lift]) { Xaxis(); }
}

//%translate([-Base_X/2-40,-15,Z_lift-40]) { cube([55,70,80]); }

color("green")
% union() {
  thisX=100;
  translate([-Tubo_H_L/2+Cojin_H_L+2,Z_axis_MT_sep,Z_lift]) {
  rotate([0,-90,0]){
    difference() {  
    translate([0,0,42]) { cube([70,70,80],center=true); }
    union() {
      cylinder(h=thisX,d=Acop_D+2);
      translate([X_axis_sep/2,0,0]){ cylinder(h=Cojin_H_L+5,d=Cojin_H_D); }
      translate([-X_axis_sep/2,0,0]){ cylinder(h=Cojin_H_L+5,d=Cojin_H_D); }
  }
  }
    
  }}
}