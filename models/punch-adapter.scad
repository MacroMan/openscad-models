include <../scripts/common.scad>

/* [Geometry] */
// Outer diameter
od = 20;
// Internal diameter, first half (bottom)
id1 = 1.5;
// Bottom half length
len1 = 20;
// Internal diameter, second half (top)
id2 = 14;
// Top half length
len2 = 20;
// Overall length
length = len1 + len2;

echo(str("OD: ", od, "mm  ID1: ", id1, "mm  ID2: ", id2, "mm  Length: ", length, "mm"));

// One object for the slicer
difference() {
    down((len1-len2)/2) cyl(d=od, h=length, anchor=BOTTOM, chamfer1=0.5, chamfer2=0.5, center=true);

    // Bottom-half bore (id1)
    down(len1/2)
        cyl(d=id1, h=len1 + _epsilon, anchor=BOTTOM, center=true);

    // Top-half bore (id2)
    up(len2/2)
        cyl(d=id2, h=len2 + _epsilon, anchor=BOTTOM, center=true);
}
