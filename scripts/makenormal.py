import glyphsLib
import sys
import copy

font = glyphsLib.GSFont(sys.argv[-2])
for glyph in font.glyphs:
    for layer in copy.copy(glyph.layers):
        if layer.name.startswith("Color "):
            del glyph.layers[layer.layerId]

font.save(sys.argv[-1])
