# Fail fast
set -e

# Build Normal Font

echo "Make Normal version of Cairo.glyphs"
python3 scripts/makenormal.py sources/Cairo.glyphs sources/CairoNormal.glyphs

echo "Build Normal Font"
gftools builder sources/cairo.yaml

echo "Rename"
mv "fonts/Cairo/variable/CairoNormal[slnt,wght].ttf" "fonts/Cairo/variable/Cairo[slnt,wght].ttf"

echo "Slice"
fonttools varLib.instancer -o "fonts/Cairo/variable/Cairo[slnt,wght].ttf" "fonts/Cairo/variable/Cairo[slnt,wght].ttf" wght=200:900

echo "Purge instances"
python3 scripts/shrinkinstances.py "fonts/Cairo/variable/Cairo[slnt,wght].ttf"

echo "Delete files"
rm sources/CairoNormal.glyphs



# Build Color Font

echo "Make Color version of plain Cairo.glyphs"
python3 scripts/makecolor.py sources/Cairo.glyphs sources/CairoColor.glyphs

echo "Build Color Font"
gftools builder sources/cairocolor.yaml

echo "Slice"
fonttools varLib.instancer -o "fonts/CairoColor/variable/CairoColor[slnt,wght].ttf" "fonts/CairoColor/variable/CairoColor[slnt,wght].ttf" wght=200:900

echo "Purge instances"
python3 scripts/shrinkinstances.py "fonts/CairoColor/variable/CairoColor[slnt,wght].ttf"

echo "Delete files"
rm sources/CairoColor.glyphs

