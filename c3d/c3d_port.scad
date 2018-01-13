piece_width = 36;
piece_depth = 40;
thickness_full = 3.5;
thickness_thin = 2;
cutout1_depth = 13.5;
cutout1_width = 13.5;
htriml_depth = 5;
htrimr_depth = 5;
htrimc_depth = 10;
htrim2_width = 5;
cutout_mid_x = 18;
cutout_mid_y = 16;
port_piece_depth = 29.5;

tolerance = 0.25;

difference(){
	main_piece();
	translate([(piece_width-25.8)/2,port_piece_depth+7,thickness_thin]) 
			port_piece(12,25.8,25,port_piece_depth,18.6);

	//middle cutout
	translate([(piece_width-cutout_mid_x)/2,cutout1_depth+4,-1]) 
			cube([cutout_mid_x,cutout_mid_y,thickness_full+2]);

	//temp
	//translate([0,14,-1]) cube([piece_width,50,6]);
}

module port_piece(x1,x2,y1,y2,y3){
	linear_extrude(height=(thickness_full-thickness_thin+1))
		translate([x2,0,0]) rotate([0,0,180]) 
		polygon([ [0,0], [0,y1], [x1,y2], [x2,y3], [x2,0] ], [ [0,1,2,3,4] ]);
}


module main_piece() {
difference(){
	cube([piece_width,piece_depth,thickness_full]);
	
	cutout();

	//trim thickness
	translate([0,0,thickness_thin]) 
			cube([piece_width/2+1,htriml_depth,thickness_full]);
	translate([piece_width/2,0,thickness_thin]) 
			cube([piece_width/2+1,htrimr_depth,thickness_full]);
	translate([(piece_width-htrim2_width)/2,0,thickness_thin]) 
			cube([htrim2_width,htrimc_depth,thickness_full]);
}
}

module cutout(){
topline = 0.25;
difference(){
cube([piece_width,10,10]);
translate([piece_width/2,10,0])
	linear_extrude(height=10)
		polygon([ [0.5,topline], [0.5,-11.5], [14.5,-11.5], [9.75,-5], [piece_width/2,-5],
				[piece_width/2,topline], [-piece_width/2,topline],
				[-piece_width/2,-5], [-10.5,-5], [-14,topline]   ], 
			[ [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9] ] );
}
}

module triangle(length, width, height){
	polyhedron([[0,0,0], [0,0,height], [width,0,0], [width,0,height], 
			[0,length,0], [0,length,height] ], 
		[ [0,1,3], [0,3,2], [0,4,5], [0,5,1], [2,3,5], [2,5,4],
			[0,2,4], [1,5,3] ]);
}