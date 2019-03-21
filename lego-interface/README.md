# About

A python script for Blender to create any under or top connection for compatibility with Lego blocks.

# Usage

Copy the script in Blender 3D, edit the top options and run it.

Options:
- pinCount: How many top pins.
- entryZ: the height of the block. 2mm for the plates or 8.2mm for a normal brick size
- printTopPins: put to *true* to have pins on the brick
- printBottomEntries: put to *true* to be able to connect other bricks under this brick

# Examples

## 2x6 brick (top and bottom)
```
pinCount = [2, 6]
entryZ = 8.2

printTopPins = True
printBottomEntries = True
```

![Thumbnail](thumbnail-2x6-true-true-top.png)
![Thumbnail](thumbnail-2x6-true-true-bottom.png)
![Thumbnail](thumbnail-2x6-true-true-printing.png)
![Thumbnail](thumbnail-2x6-true-true-done.png)

## 10x10 plate (only top)
```
pinCount = [10, 10]
entryZ = 2

printTopPins = True
printBottomEntries = False
```

![Thumbnail](thumbnail-10x10-true-false-top.png)
![Thumbnail](thumbnail-10x10-true-false-bottom.png)
