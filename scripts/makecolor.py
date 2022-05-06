import glyphsLib
import sys

font = glyphsLib.GSFont(sys.argv[-2])
for instance in font.instances:
    for parameter in instance.customParameters:
        if parameter.name == "Export COLR Table":
            parameter.value = 1

font.familyName += " Color"

font.save(sys.argv[-1])
