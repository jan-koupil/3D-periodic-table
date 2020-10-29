use <MCAD/regular_shapes.scad>

$fn = 250; //exporting
// $fn = 25; //devel

/* CONFIGURATION */

D = 125; // diameter
T = 4; // grid thickness
W = 2.5; // grid width
T2 = 1.5; // grid pad thickness
W2 = 1.5; // grid pad width
rimTop = 10; // top margin
rimBottom = 3; //bottom extra margin
LaAcGap = 0.25; // Lanthanides & actinides space 
                // (in units of square tiles)
emptyPeriodD = 0.8; // empty period inset depth

BaseH = 10;
BaseYCurvature = 4;

epsilon = 0.005;

/* CONFIG END */

N = 18; // number of tiles in period
NMax = 160;
R = D / 2;
c = PI * D; // big cylinder circumference
c_rel = sqrt(N * N + 1); // big cylinder circumference - unitless
a = c / c_rel; // base tile width

tanA = 1 / N; 
alpha = atan(tanA); // helix slope
cosA = N / sqrt(1 + N * N);

dx = a * cosA; // circumference step per tile
dz = - a * sqrt( 1 - cosA * cosA); // z step per hex 
dPhi = 360 / c * dx;

H = -NMax * dz + a * ( 1 + LaAcGap) + rimBottom + rimTop;
h = R - (R-T) * cos(dPhi / 2);

echo ("Grid diameter =", D);
echo ("Grid height =", H + BaseH);
echo ("Tile a =", a - W);

difference() {
    cylinder(r1 = R, r2 = R, h = H);
    translate([0, 0, -epsilon])
        cylinder(r1 = R - T, r2 = R - T, h = H + 2 * epsilon);

    translate([0, 0, H - a / 2 - rimTop]) {
        for (i = [0:NMax]){
            if (exists(i)) {
                shift = i <= 125 ? 0 : a * LaAcGap;
                twist = i <= 125 ? 0 :  -shift * tanA / R * 180 / PI;
                translate ([0,0, -shift]) {
                    rotate ([0, 0, twist]) {
                        block(a=a - W, h = h-T2, R = R, i = i);
                        block(a=a -W-2*W2, h = h, R = R, i = i);
                    }
                }
            }
        }
    }

    translate([0,0,8.26*a + rimBottom])
    rotate([0,0,-79])
    spiral(0.880, a / cosA);

    translate([0,0,7.55*a + rimBottom])
    rotate([0,0,-60])
    spiral(0.5475, a / cosA);

    translate([0,0,6.55*a + rimBottom])
    rotate([0,0,-61.1])
    spiral(0.5475, a / cosA);  

}

translate([0, 0, -BaseH + BaseYCurvature])
    cylinder(r1 = R, r2 = R, h = BaseH - BaseYCurvature + epsilon);

translate([0, 0, -BaseH])
    cylinder(r1 = R - BaseYCurvature, r2 = R - BaseYCurvature, h = BaseH+ epsilon);

translate([0, 0, -BaseH + BaseYCurvature])
    rotate_extrude(convexity = 10)
        translate([R - BaseYCurvature, 0, 0])
            circle(r = BaseYCurvature);

// block (r, h, R, 4);
module block(a, h, R, i) {
    rotate([0, 0, i * dPhi])
        translate([0,-R + h/2 -epsilon, i * dz])
             rotate([0, alpha, 0])
                        cube(size=[a, h + 2 * epsilon, a], center=true);
}

function exists(i) = 
    !(
        (i < 0 || i > NMax - 1)
        || (i > 0 && i < 17)
        || (i > 19 && i < 30)
        || (i > 37 && i < 48)
        || (i > 125 && i < 127)
        || (i > 141 && i < 145)
    );

use <dotSCAD/src/helix_extrude.scad>;

//spiralTurns = 0.880;
//spiralTurns = 1;




module spiral(spiralTurns, level_dist) {

    spiralHeight = (a - W) * cosA;
    shape_pts = [
        [1, 0],
        [-emptyPeriodD-epsilon, 0], 
        [-emptyPeriodD-epsilon, spiralHeight],
        [1, spiralHeight],
    ];    

        difference() {
        color("red")

        rotate([0, 0,  -a / 3 / (PI * (R + epsilon)) * 90])
        helix_extrude(shape_pts, 
            radius = R + epsilon, 
            levels = spiralTurns + a / 3 / (2 * (PI * R + epsilon)),
            level_dist = level_dist,
            vt_dir = "SPI_DOWN",
            $fn = 250
        );

        translate([R + epsilon, 0, spiralTurns * level_dist  + spiralHeight / 2])
        rotate([-alpha, 0, 0])
        translate([0, -a/6, 0])
        cube([a/3, a/3, 1.2*a], center=true);

        rotate([0, 0, spiralTurns * 360])
        translate([R + epsilon, 0, spiralHeight / 2])
        rotate([-alpha, 0, 0])
        translate([0, a/6, 0])
        cube([a/3, a/3, 1.2*a], center=true);
    }
}

// color("red")
// translate([0,0,8.47*a])
// rotate([0,0,-82])
// helix_extrude(shape_pts, 
//     radius = R + epsilon, 
//     levels = 0.895,
//     level_dist = a,
//     vt_dir = "SPI_DOWN",
//     $fn = 250
// );

    