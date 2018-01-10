$Wall = 1.2;
$Clearance = 0.5;
$Length = 90;
$Width = 26;
$Height = 8;
$PrintSplit = 5;
$AlignWidth = 1.3;
$AlignHeight = 1.6;

module MainShell()
{
  //Main base of shell
  difference()
  {
    cube([$Length + $Wall + $Clearance + $Wall + $Clearance, $Width + $Wall + $Clearance + $Wall + $Clearance, $Height + $Wall + $Clearance + $Wall + $Clearance], center = true);
    translate([-($Length + $Wall + $Clearance + $Wall + $Clearance) / 2, ($Width / 2) - 4.5, 0])
      rotate(30, [0, 0, 1])
        translate([0, 0, -($Height + $Wall + $Clearance + $Wall + $Clearance + 1) / 2])
          cube([20, 10, $Height + $Wall + $Clearance + $Wall + $Clearance + 1]);
    translate([-($Length + $Wall + $Clearance + $Wall + $Clearance) / 2,  -($Width / 2) + 4.5, 0])
      rotate(-30, [0, 0, 1])
        translate([0, -10, -($Height + $Wall + $Clearance + $Wall + $Clearance + 1) / 2])
          cube([20, 10, $Height + $Wall + $Clearance + $Wall + $Clearance + 1]);
  }
}

module InnerOpening()
{
  //Main base of shell
  difference()
  {
    cube([$Length + $Clearance, $Width + $Clearance, $Height + $Clearance], center = true);
    translate([-($Length + $Clearance) / 2,($Width / 2) - 5.5, 0])
      rotate(30, [0, 0, 1])
        translate([0, 0, -5])
          cube([20, 10, 10]);
    translate([-($Length + $Clearance) / 2,  -($Width / 2) + 5.5, 0])
      rotate(-30, [0, 0, 1])
        translate([0, -10, -5])
          cube([20, 10, 10]);
  }
}

module Dongle()
{
  difference()
  {
    MainShell();
    //
    InnerOpening();
    //USB opening
    translate([-$Length / 2, 0, 0])
      cube([4, 12, 5], center = true);
    //IRDA opening
    translate([$Length / 2, 0, 1.1])
      cube([4, 9, 4], center = true);
    // Port [7:0] opening
    translate([($Length / 2) - 9, 0, $Wall + $Clearance + 2])
      cube([6.3, 16.3, $Height], center = true);
    // Port [15:8] opening
    translate([($Length / 2) - 14.2, -10.75, $Wall + $Clearance + 2])
      cube([26.3, 3.7, 5], center = true);
    //Test opening
    translate([($Length / 2) - 14.2, 10.75, $Wall + $Clearance + 2])
      cube([26.3, 3.7, 5], center = true);
    //LED openings
    //Center
    translate([($Length / 2) - 18.5, 0, 2])
      cylinder(d = 1.7, h = 5, $fn = 40);
    //Bottom
    translate([($Length / 2) - 18.5, -5, 2])
      cylinder(d = 1.7, h = 5, $fn = 40);
    //Top
    translate([($Length / 2) - 18.5, 5, 2])
      cylinder(d = 1.7, h = 5, $fn = 40);
    //Left
    translate([($Length / 2) - 18.5 - 2.5, 0, 2])
      cylinder(d = 1.7, h = 5, $fn = 40);
    //Right
    translate([($Length / 2) - 18.5 + 2.5, 0, 2])
      cylinder(d = 1.7, h = 5, $fn = 40);
  }
}

module PrintBottom()
{
    difference()
    {
      translate([0, 0, ($Height + $Wall + $Clearance + $Wall + $Clearance) / 2])
        Dongle();
      //Slice top off 
      translate([-($Length + $Wall + $Wall + $Clearance + $Clearance + 2)  / 2, -($Width + $Wall + $Wall + $Clearance + $Clearance + 2) / 2, $Height + $Wall + $Wall + $Clearance + $Clearance - $PrintSplit])
        cube([$Length + $Wall + $Wall + $Clearance + $Clearance + 2, $Width + $Wall + $Wall + $Clearance + $Clearance + 2, 20]);
    }
}  

module PrintTop()
{
  difference()
  {
    translate([0, 0, ($Height + $Wall + $Clearance + $Wall + $Clearance) / 2])
      rotate(180, [1, 0, 0])
        Dongle();
    translate([-($Length + $Wall + $Wall + $Clearance + $Clearance + 2)  / 2, -($Width + $Wall + $Wall + $Clearance + $Clearance + 2) / 2, $PrintSplit + 20])
      translate([0, 0, -20])
        cube([$Length + $Wall + $Wall + $Clearance + $Clearance + 2, $Width + $Wall + $Wall + $Clearance + $Clearance + 2, 20]);
    }
    
    //Now add alignment rails
    translate([-35, (($Width + $Clearance) / 2) - $AlignWidth, $Wall])
      cube([$Length - 40, $AlignWidth, ($PrintSplit - $Wall + $AlignHeight)]);
    translate([-35, (-($Width + $Clearance) / 2) , $Wall])
      cube([$Length - 40, $AlignWidth, ($PrintSplit - $Wall + $AlignHeight)]);

    translate([(($Length + $Clearance) / 2) - $AlignWidth, (($Width + $Clearance) / 2) - 7, $Wall])
      cube([$AlignWidth, 7, ($PrintSplit - $Wall + $AlignHeight)]);
    translate([(($Length + $Clearance) / 2) - $AlignWidth, (-($Width + $Clearance) / 2) , $Wall])
      cube([$AlignWidth, 7, ($PrintSplit - $Wall + $AlignHeight)]);

    translate([(-($Length + $Clearance) / 2), (($Width + $Clearance) / 2) - 5.75, $Wall])
      rotate(-60, [0, 0, 1])
        cube([$AlignWidth + .5, 2.5, ($PrintSplit - $Wall + $AlignHeight)]);
    translate([(-($Length + $Clearance) / 2) + 2.15, -(($Width + $Clearance) / 2) + 7 - 2.5, $Wall])
      rotate(60, [0, 0, 1])
        cube([$AlignWidth + .5, 2.5, ($PrintSplit - $Wall + $AlignHeight)]);


    //LED light shields
    translate([21, 2.5, 1.0])
      cube([10, .7, 4]);
    translate([21, -2.5, 1.0])
      cube([10, .7, 4]);
    translate([24.9, -6, 1.0])
      cube([.7, 12, 4]);
    translate([27.4, -6, 1.0])
      cube([.7, 12, 4]);
}  


PrintBottom();
translate([0, $Width + 8, 0])
  PrintTop();

//Dongle();