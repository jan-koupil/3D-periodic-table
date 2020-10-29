$fn = 40;

// basic type of the tile  (hex/square)
type = "square"; 
//type = "hex";

// configure dimensions
baseWidth = 19;
baseHeight = 2.25;

// fontFamily = "Verdana";
// fontFamily = "Segoe UI";
// fontFamily = "Futura BT";
fontFamily = "Ebrima";
fontHeight =  1.2; //layers of text above base plate

/* for common elements */ 
// fonts = [
//     //  size,   bold,   italic, x-shift, y-shift(%)
//     [   3.3,    true,   false,  -27,      25      ], // atomic number
//     [   6,    true,   false,  13,      5       ], // symbol
//     [   3.3,    true,   false,  0,      -35      ], // mass
// ];

fonts = [
    //  size,   bold,   italic, x-shift, y-shift(%)
    [   3.3,    true,   false,  19,      30      ], // atomic number
    [   6,    true,   false,  -12,      2       ], // symbol
    [   3.3,    true,   false,  0,      -35      ], // mass
];

/* for La-Lu, Ac-Lr placeholders */
// fonts = [
//     //  size,   bold,   italic, x-shift, y-shift(%)
//     [   5,    true,   false,  0,      20      ], // atomic number
//     [   4,    true,   false,  0,      -6       ], // symbol
// ];
