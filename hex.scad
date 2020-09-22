use <MCAD/regular_shapes.scad>

mapping = [true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,true,true,false,false,false,false,false,false,false,false,false,false,true,true,true,true,true,true,true,true,false,false,false,false,false,false,false,false,false,false,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,false,false,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,false,false,false,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true];

h=2;


N = 18; // number of hexes in period
a = 10; // single hex width
r = a / 2 / cos(30); // single hex r

c_rel = sqrt(N * N - N + 1); // big cylinder circumference - unitless
c = a * c_rel; //big cylinder circumference
R = c / 2 / PI;


cosA = (2 * N * N - 3 * N + 1) / c_rel / (N - 1) / 2;
//cosA = (-1 + c_rel * c_rel + (N - 1) * (N - 1)) / 2/  c_rel / (N - 1);
alpha = acos(cosA);

dx = a * cosA; // circumference step per hex
dz = - a * sqrt( 1 - cosA * cosA); // z step per hex 
dPhi = 360 / c * dx;

for (i = [0:160]){
    if (mapping[i])
    hex(r=r, h=h, R = R, i = i);
}

//    hex(r=r, h=h, R = R, i = 0);

module hex(r, h, R, i) {
    rotate([0, 0, i * dPhi])
        translate([0,-R, i * dz])
            rotate([0, alpha, 0])
                translate ([0, h/2, 0])
                    rotate([90,90,0])
                        hexagon_prism(h, r);
}

