use <MCAD/regular_shapes.scad>
/* CONFIGURATION */

N = 18; // number of hexes in period
D = 100; // diameter
T = 3; // grid thickness
W = 1.5; // grid width
M = 1.5; // grid hex rim
I = 2.5; // "blind" hex depth (inset)
O = 0.7; // grid hex outset
shiftLaAc = 1; //fraction of r 


BaseH = 3;
BaseYCurvature = 3;

$fn = 160;
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

n = 200;
difference() {
    translate([0,0, -n * dz - 6/5*r])
        tableBody(n, true);
    translate([0,0,-H / 2])
        cube([3 * R, 3 * R, H], center = true);
}
bottom(R, BaseYCurvature, T, BaseH);


//* one hex to test print *//
// rotate([0, -90, 0])
//                         difference() 
//                         {
//                             elementTile(r, T, R + O, alpha, W);
//                             elementCut(r, T, R + O, alpha, W, M, I);
//                         }

module tableBody(n, cutLaAc) 
{
    difference() 
    {
        for (i = [0:n])  //elements dont have position over 160, it just makes the cylinder below
        {
            if (isRegular(i))
                color("lime")
                    translate([0, 0 ,i * dz]) rotate([0,0,i * dPhi])
                        render() difference() 
                        {
                            elementTile(r, T, R + O, alpha, W);
                            elementCut(r, T, R + O, alpha, W, M, I);
                        }

            if (isLaAc(i))
                color("lime")
                    translate([0, 0 ,i * dz - shiftLaAc * r * cosA]) rotate([0,0,i * dPhi - shiftLaAc * r * sin(alpha)])
                        elementTile(r, T, R + O, alpha, W);


            if (isFullCylinder(i))
                color("cyan")
                    translate([0, 0 ,i * dz]) rotate([0,0,i * dPhi])
                        fullHex(r, T, R, alpha);

        }

        if (cutLaAc)
            {
                for (i = [0:160])  //elements dont have position over 160, it just makes the cylinder below
                {
                    if (isLaAc(i))
                        color("lime")
                            translate([0, 0 ,i * dz - shiftLaAc * r * cosA]) rotate([0,0,i * dPhi - shiftLaAc * r * sin(alpha)])
                                elementCut(r, T, R + O, alpha, W, M, I);

                }
            }
    }

}


module bottom(R, BaseYCurvature, T, BaseH) {

    translate([0,0,-BaseH + BaseYCurvature])
    {
        difference() {
            cylinder(r1 = R, r2 = R, h = BaseH - BaseYCurvature + epsilon);
            translate([0,0,-2*epsilon])
            cylinder(r1 = R - T, r2 = R - T, h = BaseH - BaseYCurvature + 4 * epsilon);
        }

        difference() {
            roundCylinder(R, BaseYCurvature);
            translate([0,0,epsilon])
                roundCylinder(R - T, BaseYCurvature - T);
        }
    }
}

module roundCylinder(R, r) {
    intersection() 
    {
        rotate_extrude(convexity = 10)
                union() {
                    translate([0, -r, 0])
                        square(size=[R - r, 2 * r], center=false);
                    translate([R - r, 0, 0])
                        circle(r = r);
                }
        translate([0, 0, -r/2])            
            cube([2 * R,  2 * R, r], center = true);
    }
}


module fullHex(r, thick, R, alpha) {
    render() intersection()
    {
        difference() 
        {
            cylinder(r=R, h=2 * r, center=true);
            cylinder(r=R - thick, h=2 * r + epsilon, center=true);
        }
        rotate([-alpha, 0, 0]) rotate([0,90,0])
            hexagon_prism(R + epsilon, r + epsilon);
    }
}

module elementTile(r, thick, R, alpha, gridWidth) {
    fullHex(r + gridWidth / 2, thick, R, alpha);
}

module elementCut(r, thick, R, alpha, gridWidth, gridMargin, gridInset) {
        translate([R - gridInset, 0, 0])
            rotate([-alpha, 0, 0]) rotate([0,90,0])
                hexagon_prism(2 * thick, r - gridWidth / 2);

        translate([R - gridInset - thick, 0, 0])
            rotate([-alpha, 0, 0]) rotate([0,90,0])
                hexagon_prism(2 * thick, r - gridWidth / 2 - gridMargin);
}

function isRegular(i) = 
    (
        (i == 0) 
        || (i >= 17 && i <= 19)
        || (i >= 30 && i <= 37)
        || (i >= 48 && i <= 125)
        
    );
    // !(
    //     (i < 0 || i > 160)
    //     || (i > 0 && i < 17)
    //     || (i > 19 && i < 30)
    //     || (i > 37 && i < 48)
    //     || (i > 125 && i < 128)
    //     || (i > 142 && i < 146)
    // );

function isFullCylinder(i) = 
    (
        i >= 126
    );    

function isLaAc(i) = (i >= 128 && i <= 142) || (i >= 146 && i <= 160);