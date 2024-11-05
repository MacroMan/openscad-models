/* [Hidden] */
_epsilon = 0.001;
_pitch = 2.54;
_pinWidth = 0.65;
_pinHeight = 11.7;
_pinOffsetZ = -2.96;
_pinOffsetXY = (_pitch / 2) - (_pinWidth / 2);

module pin() {
    color("#222")
        cube(_pitch+_epsilon);
    translate([_pinOffsetXY, _pinOffsetXY, _pinOffsetZ])
        color("gainsboro")
            cube([_pinWidth, _pinWidth, _pinHeight]);
}

module pinOffset(row, column) {
    translate([column*_pitch, row*_pitch, 0])
        pin();
}

module pinHeader(rows=1, columns=1) {
    for (row=[0:rows-1], column=[0:columns-1])
        pinOffset(row, column);
}
