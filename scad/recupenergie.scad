$fn=50;
translate([0,50.8,0]) mirror([0,1,0]) difference()
{
    cube([63.5,38.1,2]);
    translate([2.54,2.54,-0.1]) cylinder(h=10,d=3.1);
    translate([60.96,2.54,-0.1]) cylinder(h=10,d=3.1);
    translate([2.54,35.559998,-0.1]) cylinder(h=10,d=3.1);
    translate([60.96,35.559998,-0.1]) cylinder(h=10,d=3.1);
    translate([-0.25399974,7.7089,1.5]) cube([9.651999,8.382,10]);
    translate([7.62,10.16,-0.1]) cylinder(h=10,d=2.0);
    translate([7.62,13.639799,-0.1]) cylinder(h=10,d=2.0);
    translate([54.101997,22.948898,1.5]) cube([9.651999,8.382,10]);
    translate([55.879997,25.4,-0.1]) cylinder(h=10,d=2.0);
    translate([55.879997,28.879799,-0.1]) cylinder(h=10,d=2.0);
    translate([16.51,10.16,-0.1]) cylinder(h=10,d=1.5);
    translate([16.51,12.7,-0.1]) cylinder(h=10,d=1.5);
    translate([22.86,7.62,-0.1]) cylinder(h=10,d=1.5);
    translate([22.86,15.24,-0.1]) cylinder(h=10,d=1.5);
    translate([21.59,8.889999,1.5]) cube([2.54,5.08,10]);
    translate([54.101997,7.7089,1.5]) cube([9.651999,8.382,10]);
    translate([55.879997,10.16,-0.1]) cylinder(h=10,d=2.0);
    translate([55.879997,13.639799,-0.1]) cylinder(h=10,d=2.0);
    translate([12.7,24.13,-0.1]) cylinder(h=10,d=1.5);
    translate([20.32,24.13,-0.1]) cylinder(h=10,d=1.5);
    translate([13.969999,22.86,1.5]) cube([5.08,2.54,10]);
    translate([12.7,30.48,-0.1]) cylinder(h=10,d=1.5);
    translate([20.32,30.48,-0.1]) cylinder(h=10,d=1.5);
    translate([13.969999,29.21,1.5]) cube([5.08,2.54,10]);
    translate([24.13,24.13,-0.1]) cylinder(h=10,d=1.5);
    translate([31.75,24.13,-0.1]) cylinder(h=10,d=1.5);
    translate([25.4,22.86,1.5]) cube([5.08,2.54,10]);
    translate([24.13,30.48,-0.1]) cylinder(h=10,d=1.5);
    translate([31.75,30.48,-0.1]) cylinder(h=10,d=1.5);
    translate([25.4,29.21,1.5]) cube([5.08,2.54,10]);
    translate([39.37,21.59,-0.1]) cylinder(h=10,d=1.5);
    translate([39.37,29.21,-0.1]) cylinder(h=10,d=1.5);
    translate([48.26,21.59,-0.1]) cylinder(h=10,d=1.5);
    translate([48.26,29.21,-0.1]) cylinder(h=10,d=1.5);
    translate([46.989998,22.86,1.5]) cube([2.54,5.08,10]);
    translate([-0.25399974,24.218899,1.5]) cube([9.651999,8.382,10]);
    translate([7.62,26.67,-0.1]) cylinder(h=10,d=2.0);
    translate([7.62,30.1498,-0.1]) cylinder(h=10,d=2.0);
    translate([-70.866,-16.383,1]) linear_extrude(10) mirror([0,1,0]) text("Psolaire",size=3);
    translate([5.08,5.08,1]) linear_extrude(10) mirror([0,1,0]) text("PSolaire",size=3);
    translate([0.0,21.59,1]) linear_extrude(10) mirror([0,1,0]) text("Eolienne",size=3);
    translate([23.876,-29.464,1]) linear_extrude(10) mirror([0,1,0]) text("Sortie solaire",size=3);
    translate([30.48,5.08,1]) linear_extrude(10) mirror([0,1,0]) text("Sortie solaire",size=3);
    translate([31.75,35.559998,1]) linear_extrude(10) mirror([0,1,0]) text("Sortie Eolienne",size=3);
    translate([-23.876,5.969,1]) linear_extrude(10) mirror([0,1,0]) text("null",size=3);
}
