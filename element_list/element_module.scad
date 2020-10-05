// A module file, not to be used separately, use element_demo.scad od make_element.cmd

use <MCAD/regular_shapes.scad>
include <config.scad>;
include <elements.scad>;

module element(Z) {
    No = Z - 1;
    elm = elementList[No];
    color("blue")
    rotate([0,0,90])
        translate([0,0,-baseHeight])
            hexagon_prism(baseHeight, baseWidth * tan(30));

    color("red")
        translate([fonts[0][3] * baseWidth / 100, fonts[0][4] * baseWidth / 100, 0])
            linear_extrude(height = fontHeight)
                text(text = str(elm[0]), font = font(fontFamily, fonts[0][1], fonts[0][2]), size = fonts[0][0], halign = "center", valign = "center");

    color("red")
        translate([fonts[1][3] * baseWidth / 100, fonts[1][4] * baseWidth / 100, 0])
            linear_extrude(height = fontHeight)
                text(text = str(elm[1]), font = font(fontFamily, fonts[1][1], fonts[1][2]), size = fonts[1][0], halign = "center", valign = "center");

    color("red")
        translate([fonts[2][3] * baseWidth / 100, fonts[2][4] * baseWidth / 100, 0])
            linear_extrude(height = fontHeight)
                text(text = str(elm[2]), font = font(fontFamily, fonts[2][1], fonts[2][2]), size = fonts[2][0], halign = "center", valign = "center");

}

function font(family, bold, italic) = 
    (bold && italic) ? str(fontFamily, ":style=Bold Italic") :
    (bold) ? str(fontFamily, ":style=Bold") :
    (italic) ? str(fontFamily, ":style=Italic") :
    family;
