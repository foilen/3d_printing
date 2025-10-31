// Stairs parameters
numSteps = 5;
stepHeight = 8;  // mm
width = 15;         // mm
stepDepth = 15; // mm
stepThickness = 2;  // mm

// Magnet parameters
magnetDiameter = 8;  // mm
magnetDepth = 2;  // mm
magnetMargin = 2;  // mm (additional diameter and depth)

// Module to create magnet housing
module magnetHousing(posX, posZ, withHollow=true) {
    translate([posX, magnetDepth+magnetMargin, posZ])
        rotate([90, 0, 0])
            difference() {
                // Large cylinder with margin
                cylinder(h = magnetDepth + magnetMargin, d = magnetDiameter + magnetMargin, $fn=50);

                // Hollowed cylinder for the magnet
                if (withHollow) {
                    translate([0, 0, magnetMargin])
                        cylinder(h = magnetDepth, d = magnetDiameter, $fn=50);
                }
            }
}

// Stairs generation
union() {
    // Main staircase
    difference() {
        for (i = [0:numSteps-1]) {
            // Step
            translate([i * stepDepth, 0, i * stepHeight])
                cube([stepDepth, width, stepThickness]);

            // Riser
            if (i > 0) {
                translate([i * stepDepth, 0, (i - 1) * stepHeight ])
                    cube([stepThickness, width, stepHeight + stepThickness]);
            }
        }

        magnetHousing(stepDepth, stepHeight / 2, false);
        magnetHousing((numSteps - 1) * stepDepth, (numSteps - 2) * stepHeight + stepHeight / 2, false);
    }

    // Magnet housings
    // First housing (first riser)
    magnetHousing(stepDepth, stepHeight / 2);

    // Last housing (second to last riser)
    magnetHousing((numSteps - 1) * stepDepth, (numSteps - 2) * stepHeight + stepHeight / 2);
}

// Extra detached magnet housings
// Positioned in negative X axis, one above the other with 5mm separation
translate([-(magnetDiameter + magnetMargin + 5), width, 0])
    rotate([90, 0, 0])
        difference() {
            cylinder(h = magnetDepth + magnetMargin, d = magnetDiameter + magnetMargin, $fn=50);
            translate([0, 0, magnetMargin])
                cylinder(h = magnetDepth, d = magnetDiameter, $fn=50);
        }

translate([-(magnetDiameter + magnetMargin + 5), width, magnetDiameter + magnetMargin + 5])
    rotate([90, 0, 0])
        difference() {
            cylinder(h = magnetDepth + magnetMargin, d = magnetDiameter + magnetMargin, $fn=50);
            translate([0, 0, magnetMargin])
                cylinder(h = magnetDepth, d = magnetDiameter, $fn=50);
        }
