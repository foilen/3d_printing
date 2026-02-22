// Rectangular base parameters
baseWidth = 50.8;
baseHeight = 50.8;
solid = 3;
wallHeight = 50.8;

// Panel
panelWidth = 3;
panelMargin = 0.2;

// Hole parameters
holeDiameter = 1;
holeSpacing = 3;
holeRows = 6;
holeLeftRightSpacing = 10;

// Bump parameters
bumpHeight = 2;

// Calculations
cutWidth = panelWidth + panelMargin;
poleWidth = 2 * solid + cutWidth;

// Module for panel cutout
module panelCutout() {
    cube([2 * solid, cutWidth, wallHeight]);
}

// Module for back wall insert for panel
module backWallInsert() {
    difference() {
        cube([poleWidth, poleWidth, wallHeight]);
        // Panel cutout pointing towards y-
        translate([solid, 0, 0])
            cube([cutWidth, cutWidth, wallHeight]);
    }
}

// Create rectangular base
cube([baseWidth, baseHeight, solid]);

// Bump on front side
translate([0, 0, solid])
    cube([baseWidth, solid/2, bumpHeight]);

// Bump on left side
translate([0, 0, solid])
    cube([solid/2, baseHeight, bumpHeight]);

// Bump on right side
translate([baseWidth - solid/2, 0, solid])
    cube([solid/2, baseHeight, bumpHeight]);

// Front wall - Insert for panel (left side)
translate([0, 0, solid]) {
    difference() {
        cube([poleWidth, poleWidth, wallHeight]);
        // Panel cutout pointing towards x+
        translate([solid + cutWidth, solid, 0])
            cube([solid, cutWidth, wallHeight]);
        // Panel cutout pointing towards y+
        translate([solid, solid + cutWidth, 0])
            cube([cutWidth, cutWidth, wallHeight]);
    }
}

// Front wall - Insert for panel (right side)
translate([baseWidth - poleWidth, 0, solid]) {
    difference() {
        cube([poleWidth, poleWidth, wallHeight]);
        // Panel cutout pointing towards x-
        translate([0, solid, 0])
            cube([solid, cutWidth, wallHeight]);
        // Panel cutout pointing towards y+
        translate([solid, solid + cutWidth, 0])
            cube([cutWidth, cutWidth, wallHeight]);
    }
}

// Back wall - Insert for panel (left side)
translate([0, baseHeight - poleWidth, solid]) {
    backWallInsert();
}

// Back wall - Insert for panel (right side)
translate([baseWidth - poleWidth, baseHeight - poleWidth, solid]) {
    backWallInsert();
}

// Wall on x side at farthest y
difference() {
    translate([0, baseHeight - solid, solid])
        cube([baseWidth, solid, wallHeight]);
    
    // Grid of holes in upper half of wall
    for (row = [0:holeRows-1]) {
        for (col = [0:floor((baseWidth - 2 * holeLeftRightSpacing) / holeSpacing)]) {
            translate([holeLeftRightSpacing + col * holeSpacing, 
                       baseHeight - solid/2, 
                       solid + wallHeight/2 + row * holeSpacing])
                rotate([90, 0, 0])
                    cylinder(h = solid + 1, d = holeDiameter, center = true, $fn = 20);
        }
    }
}

// Cover
// translate([0, 0, wallHeight + solid]) // Put on the base
translate([1.25*baseWidth, 0, 0]) { // Put on the side
    difference() {
        cube([baseWidth, baseHeight, poleWidth]);
        // Rectangular hole in the middle
        translate([poleWidth, poleWidth, 0])
            cube([baseWidth - 2 * poleWidth, baseWidth - 2 * poleWidth, poleWidth]);
        // Insert from behind to insert in the x-y plane
        translate([poleWidth - solid/2, 1.5*solid+cutWidth, poleWidth/2 - cutWidth/2])
            cube([baseWidth - 2 * poleWidth + solid, solid/2 + baseWidth - poleWidth, cutWidth]);
        // Insert to fit with the inserts on the front wall
        translate([solid + cutWidth, solid, 0])
            cube([baseWidth - 2 * (solid + cutWidth), cutWidth, poleWidth]);
    }
    
    // Bump on left side
    translate([0, poleWidth + panelMargin, poleWidth])
        cube([solid/2, baseHeight - 2 * (poleWidth + panelMargin), bumpHeight]);
    
    // Bump on right side
    translate([baseWidth - solid/2, poleWidth + panelMargin, poleWidth])
        cube([solid/2, baseHeight - 2 * (poleWidth + panelMargin), bumpHeight]);
}
