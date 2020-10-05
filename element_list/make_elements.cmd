@ECHO OFF
SET executable="c:\Program Files\OpenSCAD\openscad.com"
SET scadfile=cmdline_element.scad
SET outputdir=stl

FOR /L %%Z IN (1,1,118) DO (
    echo "Generating element Z=%%Z"
        %executable% -o %outputdir%\element_%%Z.stl -D "Z=%%Z" %scadfile%
    )
)