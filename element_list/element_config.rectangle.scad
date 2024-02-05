$fn = 40;

// basic type of the tile  (hex/square)
type = "square"; 
//type = "hex";

// levelText = true;
levelText = false;

// configure dimensions
baseWidth = 18.6;
baseHeight = 2.75;

// fontFamily = "Verdana";
// fontFamily = "Segoe UI";
fontFamily = "Futura BT";
// fontFamily = "Ebrima";
fontHeight =  1.2; //layers of text above base plate

/* for common elements */ 
// fonts = [
//     //  size,   bold,   italic, x-shift, y-shift(%)
//     [   3.3,    true,   false,  -27,      25      ], // atomic number
//     [   6,    true,   false,  13,      5       ], // symbol
//     [   3.3,    true,   false,  0,      -35      ], // mass
// ];

/* for common elements */ 
/* good without leveling */
// fonts = [
//     //  size,   bold,   italic, x-shift, y-shift(%), halign, valign
//     [   3.3,    false,   false,  43,      32.5,     "right", "center" ], // atomic number
//     [   6,      true ,   false,  -8,      2.5 ,     "center", "center" ], // symbol
//     [   3.3,    false,   false,  0,      -32.5,     "center", "center" ], // mass
// ];

/* with leveling */
// fonts = [
//     //  size,   bold,   italic, x-shift, y-shift(%)
//     [   3.3,    true,   false,  20,      30      ], // atomic number
//     [   6,      true,   false,  -8,      0       ], // symbol
//     [   3.3,    true,   false,  0,       -35     ], // mass
// ];


/* for La-Lu, Ac-Lr placeholders */
fonts = [
    //  size,   bold,   italic, x-shift, y-shift(%)
    [   5,    false,   false,  40,      27,     "right", "center" ], // atomic number
    [   4,    true ,   false,  0,      -10 ,     "center", "center" ], // symbol
];


// taken from main script
N = 18;
c_rel = sqrt(N * N - N + 1); // big cylinder circumference - unitless
cosA = (2 * N * N - 3 * N + 1) / c_rel / (N - 1) / 2;
alpha =  levelText ? acos(cosA) : 0;