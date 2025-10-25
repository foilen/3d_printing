// Options
pinCount = [2, 6];
entryZ = 8.2;  // 2: Half brick ; 8.2: Full brick

printTopPins = true;
printBottomEntries = true;

// Adjustements
pinHalf = 4; // The full size of a pin + its space = 8mm
pinFull = pinHalf * 2;
pinRadius = 2.43;
pinSpace = pinHalf - pinRadius;
pinZ = 2;
entryBorder = 1.56;
entryRadius = 3.14;

deltaZ = printBottomEntries ? entryZ : 0;

length = [ (pinRadius + pinSpace) * 2 * pinCount[0] , (pinRadius + pinSpace) * 2 * pinCount[1] ];

module lego_brick() {
    union() {
        // Top plane
        translate([length[0]/2, length[1]/2, 0.5 + deltaZ])
            cube([length[0], length[1], 1], center=true);

        // Top Pins
        if (printTopPins) {
            for (x = [0:pinCount[0]-1]) {
                for (y = [0:pinCount[1]-1]) {
                    xInit = (pinRadius*2 + pinSpace*2)*x;
                    yInit = (pinRadius*2 + pinSpace*2)*y;
                    translate([xInit + (pinSpace+pinRadius), yInit + (pinSpace+pinRadius), 1 + pinZ/2 + deltaZ])
                        cylinder(h=pinZ, r=pinRadius, center=true, $fn=50);
                }
            }
        }

        // Bottom entries
        if (printBottomEntries) {
            // Borders
            translate([entryBorder/2, length[1]/2, -entryZ/2 + deltaZ])
                cube([entryBorder, length[1], entryZ], center=true);
            translate([length[0] - entryBorder/2, length[1]/2, -entryZ/2 + deltaZ])
                cube([entryBorder, length[1], entryZ], center=true);

            translate([length[0]/2, entryBorder/2, -entryZ/2 + deltaZ])
                cube([length[0], entryBorder, entryZ], center=true);
            translate([length[0]/2, length[1] - entryBorder/2, -entryZ/2 + deltaZ])
                cube([length[0], entryBorder, entryZ], center=true);

            // Pins entries (hollow cylinders)
            insideLength = [ length[0] - 2, length[1] - 2 ];
            for (x = [0:pinCount[0]-2]) {
                for (y = [0:pinCount[1]-2]) {
                    xInit = (x+1)*pinFull;
                    yInit = (y+1)*pinFull;
                    translate([xInit, yInit, -entryZ/2 + deltaZ])
                        difference() {
                            cylinder(h=entryZ, r=entryRadius, center=true, $fn=50);
                            cylinder(h=entryZ+0.1, r=entryRadius-0.6, center=true, $fn=50);
                        }
                }
            }
        }
    }
}

lego_brick();
