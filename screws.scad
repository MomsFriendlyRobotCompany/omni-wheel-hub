// https://www.engineersedge.com/hardware/standard_metric_hex_nuts_13728.htm
// m2: d=4    D=4.62
// m3: d=5.5  D=6.35
module hex(D,t){
    x = D/2;
    y = sqrt(3)/2*x;
    pts = [
        [x/2,y],
        [x,0],
        [x/2,-y],
        [-x/2,-y],
        [-x,0],
        [-x/2,y]
    ];
    linear_extrude(height=t){
        polygon(pts);
    }
}

module M3Nut(t){
    hex(6.4, t);
    cylinder(h=2*t, d=3.3, center=true);
}

module M2(h){
    cylinder(h, d=2.2);
}

module M3(h){
    cylinder(h=h, d=3.3);
}
