import glyphsLib
import sys
import copy

# Remove all Color layers
font = glyphsLib.GSFont(sys.argv[-2])
for glyph in font.glyphs:
    for layer in copy.copy(glyph.layers):
        if layer.name.startswith("Color "):
            del glyph.layers[layer.layerId]

# Remove color palettes so COLR table won't get created
for master in font.masters:
    if master.customParameters["Color Palettes"]:
        del master.customParameters["Color Palettes"]

font.save(sys.argv[-1])

