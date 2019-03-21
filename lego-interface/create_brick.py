import bpy

# Options
pinCount = [2, 6]
entryZ = 8.2  # 2: Half brick ; 8.2: Full brick

printTopPins = True
printBottomEntries = True

# Adjustements
pinHalf = 4 # The full size of a pin + its space = 8mm
pinFull = pinHalf * 2
pinRadius = 2.43
pinSpace = pinHalf - pinRadius
pinZ = 2
entryBorder = 1.56
entryRadius = 3.14

deltaZ = 0
if printBottomEntries:
    deltaZ += entryZ

bpy.ops.script.python_file_run(filepath="/usr/share/blender/scripts/presets/units_length/millimeters.py")

length = [ (pinRadius + pinSpace) * 2 * pinCount[0] , (pinRadius + pinSpace) * 2 * pinCount[1] ]

# Top plane
bpy.ops.mesh.primitive_cube_add(location=(length[0]/2, length[1]/2, 0.5 + deltaZ))
bpy.context.object.dimensions = [ length[0], length[1], 1]

# Top Pins
if printTopPins:
    for x in range(pinCount[0]):
        for y in range(pinCount[1]):
            xInit = (pinRadius*2 + pinSpace*2)*x
            yInit = (pinRadius*2 + pinSpace*2)*y
            bpy.ops.mesh.primitive_cylinder_add(radius=pinRadius, depth=pinZ, location=( xInit + (pinSpace+pinRadius), yInit + (pinSpace+pinRadius), 1 + pinZ/2 + deltaZ))

# Bottom entries
if printBottomEntries:
    # Borders
    bpy.ops.mesh.primitive_cube_add(location=(entryBorder/2, length[1]/2, -entryZ/2 + deltaZ))
    bpy.context.object.dimensions = [ entryBorder, length[1], entryZ]
    bpy.ops.mesh.primitive_cube_add(location=(length[0] - entryBorder/2, length[1]/2, -entryZ/2 + deltaZ))
    bpy.context.object.dimensions = [ entryBorder, length[1], entryZ]

    bpy.ops.mesh.primitive_cube_add(location=(length[0]/2, entryBorder/2, -entryZ/2 + deltaZ))
    bpy.context.object.dimensions = [ length[0], entryBorder, entryZ]
    bpy.ops.mesh.primitive_cube_add(location=(length[0]/2, length[1] - entryBorder/2, -entryZ/2 + deltaZ))
    bpy.context.object.dimensions = [ length[0], entryBorder, entryZ]

    # Pins entries
    insideLength = [ i - 2 for i in length ]
    for x in range(pinCount[0] - 1):
        for y in range(pinCount[1] - 1):
            xInit = (x+1)*pinFull
            yInit = (y+1)*pinFull
            bpy.ops.mesh.primitive_cylinder_add(radius=entryRadius, depth=entryZ, location=( xInit, yInit, -entryZ/2 + deltaZ), end_fill_type = 'NOTHING')
            bpy.ops.object.modifier_add(type='SOLIDIFY')
            bpy.context.object.modifiers["Solidify"].thickness = 0.6
