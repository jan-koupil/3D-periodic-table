use <MCAD/regular_shapes.scad>

//$fn = 150;
$fn = 30;

function hexType (i) = 
    (
        (i < 0) 
        || (i > 0 && i < 17)
        || (i > 19 && i < 30)
        || (i > 37 && i < 48)
    ) ? "none" :
    ( 
        (i > 125 && i < 129)
        || (i > 143 && i < 147)
    ) ? "filled" :
    ( i > 161 ) ? "solid" :
    "grid";

// h=8; // increase when hexes are not cut through the wall fully

/* CONFIGURATION */

N = 18; // number of hexes in period
D = 100; // diameter
T = 3; // grid thickness
W = 1.5; // grid width
I = 2.5; // "blind" hex depth
M = 1.5; // grid hex rim
O = 0.7; // grid hex outset

BaseH = 10;
BaseYCurvature = 3;


epsilon = 0.005;

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

h = R - (R - T) * cos (dPhi / 2) + 10;

H = -161 * dz + 2 * r;

echo ("Grid diameter =", D);
echo ("Grid height =", H + W + BaseH);
echo ("Hex r =", r);
echo ("Hex a =", a);

intersection() {
    translate([0, 0, H - r + W]) {
        for (i = [0:161 + 2 * 18]) {
            type = hexType(i);
            if (type != "none") {
                rotate([0, 0, i * dPhi])
                    translate([0, 0, i * dz])
                        segment(r, h, R, T, W, I, O, M, type);
            }            
        }
    }
    translate([0, 0, H])
        cube([2 * D, 2 * D, 2 * H], center = true);
}

translate([0, 0, -BaseH + BaseYCurvature])
    cylinder(r1 = R, r2 = R, h = BaseH - BaseYCurvature + epsilon);

translate([0, 0, -BaseH])
    cylinder(r1 = R - BaseYCurvature, r2 = R - BaseYCurvature, h = BaseH+ epsilon);

translate([0, 0, -BaseH + BaseYCurvature])
    rotate_extrude(convexity = 10)
        translate([R - BaseYCurvature, 0, 0])
            circle(r = BaseYCurvature);

// segment(r, h, R, T, W, I, O, M, type = "grid");


module segment(r, h, R, T, W, I, O, M, type) {

    realR = ( type == "grid" || type == "filled") ? R + O : R;
    realT = ( type == "grid" || type == "filled") ? T + O : T;

    //hex(r = r + W / 2, h = h, R = realR);
    //hex(r = r + W / 2, h = h, R = realR, type="special");

    difference() {

        intersection() {
            color("lime", 1)
                translate([0, 0, -r - W/2])
                    difference() {
                        cylinder(r1 = realR, r2 = realR, h = 2 *r + W);
                        translate([0, 0, -epsilon])
                            cylinder(r1 = realR - realT, r2 = realR - realT, h = 2 *r + W + 2 * epsilon);
                    }

            color("orange", 1)
                hex(r = r + W / 2, h = h, R = realR, type="special");
        }

        if (type == "grid") {
            hex(r = r - W / 2, h = I, R = realR + epsilon);
            hex(r = r - W / 2 - M, h = h, R = realR + epsilon);
        }
        else if (type == "filled")
            hex(r = r - W / 2, h = I, R = realR + epsilon);

    }

}

module hex(r, h, R, type = "regular") {
    translate([0,-R-h, 0])
        rotate([0, alpha, 0])
            translate ([0, h, 0])
                rotate([-90,90,0])
                    if (type == "regular") {
                        hexagon_prism(h, r);
                    }
                    else if (type == "special") {   // pyramidal type                          
                        linear_extrude(height = h, center = false, convexity = 10, scale=[1, 1-h/R], slices=10)
                            hexagon(r); 
                    }

}

