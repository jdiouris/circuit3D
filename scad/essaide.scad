$fn=50;
translate([0,50.8,0]) mirror([0,1,0]) difference()
{
    cube([76.2,50.8,2]);
    translate([2.54,2.54,-0.1]) cylinder(h=10,d=3.1);
    translate([73.659996,2.54,-0.1]) cylinder(h=10,d=3.1);
    translate([2.54,48.26,-0.1]) cylinder(h=10,d=3.1);
    translate([73.659996,48.26,-0.1]) cylinder(h=10,d=3.1);
    translate([11.43,10.16,1.5]) cylinder(h=10,d=6.35);
    translate([10.16,10.16,-0.1]) cylinder(h=10,d=1.5);
    translate([12.7,10.16,-0.1]) cylinder(h=10,d=1.5);
}
