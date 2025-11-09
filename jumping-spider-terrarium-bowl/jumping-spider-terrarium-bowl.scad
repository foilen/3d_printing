// Bowl parameters
bowlDiameter = 30;  // mm - outer diameter of the bowl
thickness = 2;    // mm - wall thickness
height = 15; // mm - height
resolution = 200; // number of facets for cylinders

// Magnet parameters
magnetDiameter = 8;  // mm
magnetDepth = 2;  // mm
magnetMargin = 2;  // mm (additional diameter and depth)

// Mesures
bowlRadius = bowlDiameter / 2;

// Module to create magnet housing
module magnetHousing(posX, posZ, withHollow=true) {
    translate([posX, 0, posZ])
        rotate([90, 0, 0])
            difference() {
                // Large cylinder with margin
                cylinder(h = magnetDepth + magnetMargin, d = magnetDiameter + magnetMargin, $fn=resolution);

                // Hollowed cylinder for the magnet
                if (withHollow) {
                    translate([0, 0, magnetMargin])
                        cylinder(h = magnetDepth, d = magnetDiameter, $fn=resolution);
                }
            }
}

// Bowl generation
union() {
    // Main bowl - half cylinder with wall thickness
    difference() {
        // Outer half cylinder (vertical, cut in half on Y axis)
        difference() {
            cylinder(h = height, r = bowlRadius, $fn=resolution);
            // Cut away half the cylinder (negative Y side)
            translate([-bowlRadius - 1, -bowlRadius * 2 - 1, -1])
                cube([bowlRadius * 2 + 2, bowlRadius * 2, height + 2]);
        }

        // Inner half cylinder (creates the wall thickness)
        difference() {
            translate([0, 0, thickness])
                cylinder(h = height + 2, r = bowlRadius - thickness, $fn=resolution);
            // Cut away half the inner cylinder (negative Y side)
            translate([-bowlRadius - 2, -bowlRadius * 2 - 2, thickness])
                cube([bowlRadius * 2 + 4, bowlRadius * 2, height + 4]);
        }
    }

    // Rectangular back panel on the flat cut face
    difference() {
        translate([-bowlRadius, -(magnetDepth + magnetMargin), 0])
            cube([bowlRadius * 2, magnetDepth + magnetMargin, height]);

        // Magnet housing cutouts
        magnetHousing(bowlRadius/2, height/2, false);
        magnetHousing(-bowlRadius/2, height/2, false);
    }

    // Magnet housings protruding from behind the panel
    magnetHousing(bowlRadius/2, height/2);
    magnetHousing(-bowlRadius/2, height/2);
}

// Extra detached magnet housings
// Positioned on the x-z plane to the side for printing
// Mirrored so the hole is on y+ instead of y-
translate([bowlRadius + 15, -(magnetDepth + magnetMargin), (magnetDiameter + magnetMargin)/2])
    rotate([-90, 0, 0])
        difference() {
            cylinder(h = magnetDepth + magnetMargin, d = magnetDiameter + magnetMargin, $fn=resolution);
            translate([0, 0, magnetMargin])
                cylinder(h = magnetDepth, d = magnetDiameter, $fn=resolution);
        }

translate([bowlRadius + 15, -(magnetDepth + magnetMargin), (magnetDiameter + magnetMargin)/2 + magnetDiameter + magnetMargin + 5])
    rotate([-90, 0, 0])
        difference() {
            cylinder(h = magnetDepth + magnetMargin, d = magnetDiameter + magnetMargin, $fn=resolution);
            translate([0, 0, magnetMargin])
                cylinder(h = magnetDepth, d = magnetDiameter, $fn=resolution);
        }
