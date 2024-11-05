use <../modules/pin-header.scad>


//row=[1:2], 
for (column=[1:4], row=[1:2]) {
    translate([row==1 ? 0 : 25, column*20, 0])
        pinHeader(row, column*2);
}
