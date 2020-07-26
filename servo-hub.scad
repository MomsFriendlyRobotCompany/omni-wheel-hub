// MIT Kevin Walchko 2019

$fn = 90;

// library folder
use <screws.scad>;

module servo(){
    import("lib/lx16a.stl");
}

module wheelhub(){
    difference()
    {
        thick = 10;
        s = sqrt(2*12*12/2/2);
        echo(">> square size:",s);
        cylinder(d=28, h=thick);
        translate([-s/2,-s/2,-4]) cube([s,s,thick+8]);
        for (x = [0:60:360]) rotate([0,0,x]) translate([21/2,0,-2]) M3(thick+4);
        M3(thick+10);
    }
}

module servohub(){
    // LX-16A
    thick = 2;
    s = 8.3;
    h = 21;
    difference()
    {
        union(){
            cylinder(d=25, h=thick);  // servo face plate
            translate([0,0,thick]) cylinder(d=14, h=8);  // offset
            translate([-s/2,-s/2,thick]) cube([s,s,h]);
        }
        // 17 mm holes
        translate([17/2,0,-2]) M2(thick+4);
        translate([17/2,0,2]) cylinder(d=4.5, h=12);
        rotate([0,0,180]) {
            translate([17/2,0,-2]) M2(thick+4);
            translate([17/2,0,2]) cylinder(d=4.5, h=12);
        }

        // 14 mm holes
        rotate([0,0,90]) {
            translate([14/2,0,-2]) M2(thick+4);
            translate([14/2,0,2]) cylinder(d=4.5, h=12);
        }
        rotate([0,0,270]) {
            translate([14/2,0,-2]) M2(thick+4);
            translate([14/2,0,2]) cylinder(d=4.5, h=12);
        }

        cylinder(d=2.5,h=h+5);  // self-tapping screw
        translate([0,0,-1]) cylinder(d=8.5,h=2.5); // bolt and bump out
    }
}

module servohub2(){
    // AX-12A
    thick = 2;
    s = 8.3;
    /* h = 21; */
    wheelcube = 13; // length from wheel face to face
    hub = 7;  // offset from servo face to wheel face, 8
    h = wheelcube + hub;
    difference()
    {
        union(){
            cylinder(d=25, h=thick);  // servo face plate
            translate([0,0,thick]) cylinder(d=14, h=hub);  // offset
            translate([-s/2,-s/2,thick]) cube([s,s,h]);
        }
        // 16 mm holes
        ring = 16;
        /* translate([ring/2,0,-2]) M2(thick+4);
        translate([ring/2,0,2]) cylinder(d=4.5, h=12); */
            for (x = [0:90:270]){
            rotate([0,0,x]) {
                translate([ring/2,0,-1]) M2(thick+4);
                translate([ring/2,0,thick]) cylinder(d=4.5, h=12);
            }
        }

        /* // 14 mm holes
        rotate([0,0,90]) {
            translate([14/2,0,-2]) M2(thick+4);
            translate([14/2,0,2]) cylinder(d=4.5, h=12);
        }
        rotate([0,0,270]) {
            translate([14/2,0,-2]) M2(thick+4);
            translate([14/2,0,2]) cylinder(d=4.5, h=12);
        } */

        translate([0,0,hub-1]) cylinder(d=2.5,h=h+5);  // self-tapping screw
        /* translate([0,0,-1]) cylinder(d=8.5,h=2.5); // bolt and bump out */
    }
}


module wheeldisk(){
    translate([0,0,0]){
        difference()
        {
            translate([0,0,-5/2]) cylinder(d=60, h=5);
            translate([0,0,-10]) cylinder(d=12, h=20);
            for (x = [0:60:360]) rotate([0,0,x]) translate([21/2,0,-10]) M3(20);
        }
        for (x = [0:72:360]) rotate([0,0,x]) translate([48/2,0,0]) rotate([90,0,0]) cylinder(d=13, h=18.5, center=true);
    }
}

module wheel(){
    translate([0,0,0]) wheeldisk();
    translate([0,0,5/2]) wheelhub();
    translate([0,0,10+5/2]) rotate([0,0,180]) wheeldisk();
}

module hubcap(){
    difference()
    {
        stem = 2;
        offset = 6;
        union() {
            cylinder(d=12, h=stem);
            translate([0,0,stem+offset-2]) cylinder(d=35, h=2); // outer cap
            translate([0,0,stem]) cylinder(d=28, h=6); // house bolts
        }
        translate([0,0,2]) cylinder(d=7, h=15); // socket head hole down
        translate([0,0,-2]) M3(5);  // self-tapping screw hole
        for (x = [0:60:360]) rotate([0,0,x]) translate([21/2,0,stem-0.5]) M3Nut(5);
    }
}

module wheelgroup(s=true, w=true, h=true, c=true){
    if (h) servohub();
    if (s) translate([0,12,-19]) servo();
    if (w) translate([0,0,2+10+5/2-2-2]) wheel();  // I don't model the inner ring correctly .. so 2 mm down more
    if (c) translate([0,0,2+10+5/2+13-4]) hubcap();
}

wheelgroup(w=true, h=true, s=false);

/* wheeldisk(); */

/* servohub2(); */
//hubcap();
