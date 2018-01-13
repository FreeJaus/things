include <fjkb_profile.scad>

// K: keyboard
// L: lid

b_l=400; //K: Width
b_d=200; //K: Depth
b_h=30;  //K: Height
b_ang=6; //K: ANGle

l_b=10; //L: Border
l_d=50; //L: Depth

b_f=27.5; //Front height
b_e=3;    //Thickness
b_t=175;  //Top depth
b_r=1.5;  //Blending radius

rotate([90,0,0]) {

profile(b_e,b_l,b_t,b_f,b_d,b_h,b_ang,b_r);

translate([0,0,250]) {
  lid(1,b_e,l_b,l_d,b_t,b_f,b_d,b_h,b_ang,b_r);   
}

translate([0,0,-250]) {
  lid(-1,b_e,l_b,l_d,b_t,b_f,b_d,b_h,b_ang,b_r);   
}

}