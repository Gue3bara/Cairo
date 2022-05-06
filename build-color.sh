echo "Make Color version of plain Cairo.glyphs"
python3 scripts/makecolor.py sources/Cairo.glyphs sources/CairoColor.glyphs

echo "Build"
gftools builder sources/cairocolor.yaml

echo "Slice"
fonttools varLib.instancer -o "fonts/CairoColor/variable/CairoColor[wght].ttf" "fonts/CairoColor/variable/CairoColor[slnt,wght].ttf" slnt=0 wght=200:900

echo "Delete files"
rm sources/CairoColor.glyphs
rm "fonts/CairoColor/variable/CairoColor[slnt,wght].ttf"
