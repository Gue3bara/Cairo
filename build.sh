# Fail fast
set -e

# Build Normal Font

echo "Make Normal version of Cairo.glyphs"
python3 scripts/makenormal.py sources/Cairo.glyphs sources/CairoNormal.glyphs

echo "Build Normal Font"
gftools builder sources/cairo.yaml

echo "Rename"
mv "fonts/Cairo/variable/CairoNormal[slnt,wght].ttf" "fonts/Cairo/variable/Cairo[slnt,wght].ttf"

echo "Purge fvar instances"
python3 scripts/purgeinstances.py "fonts/Cairo/variable/Cairo[slnt,wght].ttf"

echo "Delete files"
rm sources/CairoNormal.glyphs



# Build Play Font

echo "Make Play version of plain Cairo.glyphs"
python3 scripts/makeplay.py sources/Cairo.glyphs sources/CairoPlay.glyphs

echo "Build Play Font"
gftools builder sources/cairoplay.yaml

echo "Purge fvar instances"
python3 scripts/purgeinstances.py "fonts/CairoPlay/variable/CairoPlay[slnt,wght].ttf"

echo "Delete files"
rm sources/CairoPlay.glyphs

