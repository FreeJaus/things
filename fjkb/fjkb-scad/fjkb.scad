plate_w=39.522;
plate_h=14.503;
plate_t=0.15;
plate_rt=.5;
plate_rth=1.25;
plate_rbh=.75;
plate_rta=85;
plate_rba=125;

pcb_w=39.522;
pcb_h=14.503;
pcb_t=0.16;

plate_pcb_sep_r=0.2;
plate_pcb_sep_h=.5;
plate_pcb_sep_wm=0.5;
plate_pcb_sep_hm=0.5;

module plate_border(w,h,t,rt,rh,ra) {
  translate([0,h/2,-rt+t/2]){
  rotate([0,-90,0]){
  union(){
    difference() {
      linear_extrude (height=w,center=true) { difference() {
        $fn=100;
        circle(r=rt);
        circle(r=rt-t);
      }}
      translate ([0,-rt/2,0]) { cube([2.5*rt,rt,w*1.5],center=true); }
      rotate([0,0,-ra]) { translate ([0,-rt/2,0]) { cube([2.5*rt,rt,w*1.5],center=true); } }
  }
    translate([-(rt-t/2)*sin(90-ra)-(rh/2)*cos(90-ra),(rt-t/2)*cos(90-ra)-(rh/2)*sin(90-ra),0]) {
      rotate([0,0,90-ra]) { cube([rh,t,w],center=true); }
    }
  }}}    
}

module plate (w,h,t,rt,rth,,rbh,rta,rba) {
  cube([w,h,t],center=true);
  plate_border(w,h,t,rt,rth,rta);
  rotate([0,0,180]) { plate_border(w,h,t,rt,rbh,rba); }
}

module backplate (w,h,t) {
  cube([w,h,t],center=true);
}

module pcb (w,h,t) {
  cube([w,h,t],center=true);
}

module plate_pcb_sep (r,h) {
  linear_extrude (height=h,center=true) {
    circle(r=r,$fn=6);
  }
}

module plate_pcb_seps (sr,sh,w,h,wm,hm) {
  translate([w/2-wm,h/2-hm,-sh/2]) {plate_pcb_sep(sr,sh);}
  translate([-w/2+wm,h/2-hm,-sh/2]) {plate_pcb_sep(sr,sh);}
  translate([w/2-wm,-h/2+hm,-sh/2]) {plate_pcb_sep(sr,sh);}
  translate([-w/2+wm,-h/2+hm,-sh/2]) {plate_pcb_sep(sr,sh);}
}

rotate ([90-plate_rta,0,0]) {
translate ([0,0,1.35]) {

translate([0,0,plate_t/2]){
  color( "LightSteelBlue", 1) {
    plate(plate_w,plate_h,plate_t,plate_rt,plate_rth,plate_rbh,plate_rta,plate_rba);
  }
}

translate([0,0,-pcb_t/2-plate_pcb_sep_h]){
  color( "DarkGreen", 1) {
    pcb(pcb_w,pcb_h,pcb_t);
  }
}

plate_pcb_seps(plate_pcb_sep_r,plate_pcb_sep_h,plate_w,plate_h,plate_pcb_sep_wm,plate_pcb_sep_hm);

}}

translate([0,0,0]) { backplate(2*plate_w,2*plate_h*1.25,0.1*plate_t); }