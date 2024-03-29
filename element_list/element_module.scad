// A module file, not to be used separately, use element_demo.scad od make_element.cmd

use <MCAD/regular_shapes.scad>
include <element_config.scad>;
include <elements.scad>;

module element(Z) {
    No = Z - 1;
    elm = elementList[No];
    color("blue")
    if (type == "hex") {
        rotate([0,0,90])
            translate([0,0,-baseHeight])
                hexagon_prism(baseHeight, baseWidth * tan(30));
    } else {
        translate([0,0,-baseHeight / 2])
            cube([baseWidth, baseWidth, baseHeight], center = true);
    }
    rotate([0,0,alpha])
        for (i = [0 : len(fonts) - 1]) {
            color("red")
            translate([fonts[i][3] * baseWidth / 100, fonts[i][4] * baseWidth / 100, 0])
                linear_extrude(height = fontHeight)
                    text(text = str(elm[i]), font = font(fontFamily, fonts[i][1], fonts[i][2]), size = fonts[i][0], halign = fonts[i][5], valign = fonts[i][6]);
        }

}

function font(family, bold, italic) = 
    (bold && italic) ? str(fontFamily, ":style=Bold Italic") :
    (bold) ? str(fontFamily, ":style=Bold") :
    (italic) ? str(fontFamily, ":style=Italic") :
    family;
