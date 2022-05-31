import sys
from glyphsLib import GSFont


def settransformedcomponents(f):

    glyphs = []

    # Collect glyphs
    for glyph in f.glyphs:
        for layer in glyph.layers:
            for i, component in enumerate(layer.components):
                if component.transform[0] != 1 or component.transform[3] != 1:
                    if [glyph, len(layer.components), i] not in glyphs:
                        glyphs.append([glyph, len(layer.components), i])

    # Adjust transform
    for glyph, component_count, i in glyphs:
        for layer in glyph.layers:
            if component_count == len(layer.components):
                if layer.components[i].transform[0] == 1:
                    layer.components[i].transform[0] = 0.999
                if layer.components[i].transform[3] == 1:
                    layer.components[i].transform[3] = 0.999


if __name__ == "__main__":
    font = GSFont(sys.argv[-1])
    settransformedcomponents(font)
    font.save(sys.argv[-1])
