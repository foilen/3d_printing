// Fan Support
// A support structure for mounting a fan

// Parameters
baseWidthX = 200;  // Width of the base along X axis
baseWidthY = 70;  // Width of the base along Y axis
baseHeight = 50;  // Height of the half oval

fanSpread = 24; // Distance between the two fan blades
fanBladeWidth = 5; // Width of each fan blade
fanMargin = 2; // Margin around the fan blades for the holes
fanCutDepth = 25; // Depth of the cut for the fan blades in the hole

polesXDistance = baseWidthX * (5/7); // Distance between poles along X axis
polesHeight = 70 + baseHeight; // Height of the poles
polesDiameter = 10 + fanBladeWidth + fanMargin; // Diameter of the poles
poleLeftInFront = false; // If true, left pole is in front (negative Y), else right pole is in front (positive Y)

// Create half oval (half ellipsoid)
module half_oval() {
    difference() {
        // Create full ellipsoid by stretching a sphere
        scale([baseWidthX/2, baseWidthY/2, baseHeight])
            sphere(r=1, $fn=20);

        // Cut away everything below z=0 (negative z)
        translate([-baseWidthX, -baseWidthY, -baseHeight-1])
            cube([baseWidthX*2, baseWidthY*2, baseHeight+1]);
    }
}

// Create poles with domes and fan blade cuts
module poles() {
    polesRadius = polesDiameter / 2;
    cutWidth = fanBladeWidth + fanMargin;

    // Determine Y positions based on poleLeftInFront
    leftPoleY = poleLeftInFront ? -fanSpread/2 : fanSpread/2;
    rightPoleY = poleLeftInFront ? fanSpread/2 : -fanSpread/2;

    // Left pole
    translate([-polesXDistance/2, leftPoleY, 0]) {
        difference() {
            union() {
                cylinder(h=polesHeight, r=polesRadius, center=false, $fn=20);
                // Dome on top
                translate([0, 0, polesHeight])
                    sphere(r=polesRadius, $fn=20);
            }
            // Rectangular cut for fan blade from top down (through dome)
            translate([-polesRadius-1, -cutWidth/2, polesHeight + polesRadius - fanCutDepth])
                cube([polesDiameter+2, cutWidth, fanCutDepth+polesRadius+1]);
        }
    }

    // Right pole
    translate([polesXDistance/2, rightPoleY, 0]) {
        difference() {
            union() {
                cylinder(h=polesHeight, r=polesRadius, center=false, $fn=20);
                // Dome on top
                translate([0, 0, polesHeight])
                    sphere(r=polesRadius, $fn=20);
            }
            // Rectangular cut for fan blade from top down (through dome)
            translate([-polesRadius-1, -cutWidth/2, polesHeight + polesRadius - fanCutDepth])
                cube([polesDiameter+2, cutWidth, fanCutDepth+polesRadius+1]);
        }
    }
}

// Display the complete model
half_oval();
poles();
