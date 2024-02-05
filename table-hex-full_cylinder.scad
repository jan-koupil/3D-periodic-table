use <MCAD/regular_shapes.scad>

$fn = 250;

function exists(i) = 
    !(
        (i < 0 || i > 161)
        || (i > 0 && i < 17)
        || (i > 19 && i < 30)
        || (i > 37 && i < 48)
        || (i > 125 && i < 128)
        || (i > 142 && i < 146)
    );

function shiftLaAc(i) = (i >= 128 && i <= 142) || (i >= 146);

h=8;

/* CONFIGURATION */

N = 18; // number of hexes in period
D = 75; // diameter
T = 2.5; // grid thickness
W = 2.5; // grid width
epsilon = 0.005;
top = 3;
bottom = 3;
baseThick = 3;
fShift = 0.5; //La and Ac y-gap in units of r

/* CONFIG END */

R = D / 2;
c = PI * D; // big cylinder circumference
c_rel = sqrt(N * N - N + 1); // big cylinder circumference - unitless
a = c / c_rel; // base hex width
r = a / 2 / cos(30); // base hex r


cosA = (2 * N * N - 3 * N + 1) / c_rel / (N - 1) / 2;
//cosA = (-1 + c_rel * c_rel + (N - 1) * (N - 1)) / 2/  c_rel / (N - 1);
alpha = acos(cosA);

dx = a * cosA; // circumference step per hex
dz = - a * sqrt( 1 - cosA * cosA); // z step per hex 
dPhi = 360 / c * dx;

H = -160 * dz + 2 * r;
fullHeight = H + top + bottom + r * fShift;

echo ("Grid diameter =", D);
echo ("Grid height =", H);
echo ("Full height =", fullHeight);
echo ("Hex r =", r);
echo ("Hex a =", a);

translate([0, 0, -baseThick + epsilon])
    cylinder(r1 = R, r2 = R, h = baseThick);

difference() {
    cylinder(r1 = R, r2 = R, h = fullHeight);
    translate([0, 0, -epsilon])
        cylinder(r1 = R - T, r2 = R - T, h = fullHeight + 2 * epsilon);

    translate([0, 0, H + bottom +r * fShift - r]) {
        for (i = [0:160]){
            if (exists(i))
                translate( shiftLaAc(i) ? [0, 0, -r * fShift] : [0, 0, 0])
                    hex(r=r - W / 2, h=h, R = R, i = i);
        }
    }
}

// translate([0, 0, H - r]) {
//     for (i = [0:161]){
//         if (exists(i))
//             hex(r=r, h=h, R = R, i = i);
//     }
// }

//    hex(r=r, h=h, R = R, i = 0);



module hex(r, h, R, i) {
    rotate([0, 0, i * dPhi])
        translate([0,-R, i * dz])
            rotate([0, alpha, 0])
                translate ([0, h, 0])
                    rotate([90,90,0])
                        hexagon_prism(h, r);
}

