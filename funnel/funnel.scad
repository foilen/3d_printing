// Parameters (mm)
TOP_DIAMETER = 80;    // Outer diameter of the top opening
BOTTOM_DIAMETER = 10; // Outer diameter of the bottom tip
HEIGHT = 70;          // Total height
WALL = 2;           // Wall thickness

$fn = 100;

// Small overlap to avoid zero-thickness faces when subtracting
eps = 0.01;

// Inner diameters, with the wall measured perpendicular-ish (kept simple: radial)
top_inner = TOP_DIAMETER - 2 * WALL;
bottom_inner = BOTTOM_DIAMETER - 2 * WALL;

difference() {
    cylinder(h = HEIGHT, d1 = BOTTOM_DIAMETER, d2 = TOP_DIAMETER);
    translate([0, 0, -eps])
        cylinder(h = HEIGHT + 2 * eps, d1 = bottom_inner, d2 = top_inner);
}
