$fn = 40;

// basic type of the tile  (hex/square)
//type = "square"; 
type = "hex";

// configure dimensions
baseWidth = 16.4;
baseHeight = 2;

// fontFamily = "Verdana";
// fontFamily = "Segoe UI";
// fontFamily = "Futura BT";
fontFamily = "Ebrima";
fontHeight =  1.2; //layers of text above base plate

/* for common elements */ 
fonts = [
    //  size,   bold,   italic, x-shift, y-shift(%)
    [   3,    true,   false,  0,      28      ], // atomic number
    [   6,    true,   false,  0,      -12       ], // symbol
//     [   2.7,    false,   false,  0,      -33      ], // mass
];

/* for La-Lu, Ac-Lr placeholders */
// fonts = [
//     //  size,   bold,   italic, x-shift, y-shift(%)
//     [   5,    true,   false,  0,      20      ], // atomic number
//     [   4,    true,   false,  0,      -6       ], // symbol
// ];
