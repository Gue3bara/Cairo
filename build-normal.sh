echo "Build"
gftools builder sources/cairo.yaml

echo "Slice"
fonttools varLib.instancer -o "fonts/Cairo/variable/Cairo[wght].ttf" "fonts/Cairo/variable/Cairo[slnt,wght].ttf" slnt=0 wght=200:900

echo "Delete files"
rm "fonts/Cairo/variable/Cairo[slnt,wght].ttf"
