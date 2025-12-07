// Constants
HEIGHT = 43; // 4.3cm in mm
ANGLE = 15; // degrees
WIDTH = 200; // 20cm in mm

// Calculate base length from height and angle
base_length = HEIGHT / tan(ANGLE);

// Create rectangular triangular prism (ramp)
linear_extrude(height = WIDTH) {
    polygon([
        [0, 0],
        [base_length, 0],
        [0, HEIGHT]
    ]);
}
