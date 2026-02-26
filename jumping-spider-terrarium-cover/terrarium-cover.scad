// Terrarium cover - grid pattern
width = 77; // mm
length = 77; // mm
height = 5; // mm
space = 2; // mm - size of each square hole
bar = 2; // mm - wall between holes
cornerWidth = 10; // mm - corner post width
cornerHeight = 20; // mm - corner post height
cornerMargin = 1; // mm - offset outward for better fitting

// Grid cover
difference() {
  cube([width, length, height]);

  // Individual square holes, each surrounded by solid material on all 4 sides
  for (col = [0:bar + space:width - bar - space]) {
    for (row = [0:bar + space:length - bar - space]) {
      translate([bar + col, bar + row, -1])
        cube([space, space, height + 2]);
    }
  }
}

// Corner posts
difference() {
  union() {
    translate([-cornerWidth / 2, -cornerWidth / 2, 0])
      cube([cornerWidth, cornerWidth, height + cornerHeight]);
    translate([width - cornerWidth / 2, -cornerWidth / 2, 0])
      cube([cornerWidth, cornerWidth, height + cornerHeight]);
    translate([-cornerWidth / 2, length - cornerWidth / 2, 0])
      cube([cornerWidth, cornerWidth, height + cornerHeight]);
    translate([width - cornerWidth / 2, length - cornerWidth / 2, 0])
      cube([cornerWidth, cornerWidth, height + cornerHeight]);
  }
  translate([-cornerMargin, -cornerMargin, height])
    cube([width + cornerMargin * 2, length + cornerMargin * 2, cornerHeight]);
}
