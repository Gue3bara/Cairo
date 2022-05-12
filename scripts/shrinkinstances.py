from axisregistry import AxisRegistry
from fontTools.ttLib import TTFont
import sys
import copy

registry = AxisRegistry()

font = TTFont(sys.argv[-1])

for instance in copy.copy(font["fvar"].instances):
    name = font["name"].getName(instance.subfamilyNameID, 3, 1, 1033).toUnicode()
    if name not in [weight.name for weight in registry["wght"].fallback] and name not in [
        weight.name + " Italic" for weight in registry["wght"].fallback
    ]:
        font["fvar"].instances.remove(instance)

font.save(sys.argv[-1])
