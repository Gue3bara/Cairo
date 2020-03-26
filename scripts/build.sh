#!/bin/bash
set -e

glyphs_source="Cairo"
output_dir="fonts"
family_name="Cairo"
build_static_fonts=true   # Set to `true` if you want to build static fonts
autohint=false            # Set to true if you want to use auto-hinting (ttfautohint)
nohinting=true            # Set to true if you want the fonts unhinted

echo "[INFO] Starting build script for $family_name font family"

if [ -d .git ]; then
  echo "[TEST] Running from a Git root directory, looks good"
else
  echo "[WARN] Font family Git root not found, please run from the root directory"
  echo "[WARN] Build process cancelled"
  exit 1
fi

for sources in $glyphs_source; do
  echo "[TEST] Queued source file: $sources.glyphs"
done

for sources in $glyphs_source; do
  echo "[INFO] Building $sources.glyphs VFs with Fontmake..."
  fontmake -g sources/$sources.glyphs -o variable \
    --output-path $output_dir/vf/$sources-VF.ttf \
    --verbose ERROR
done

if [ "$build_static_fonts" = true ]; then
  echo "[INFO] Building static fonts"
  fontmake -g sources/Cairo.glyphs -i "Cairo ExtraLight" --verbose ERROR
  fontmake -g sources/Cairo.glyphs -i "Cairo Light" --verbose ERROR
  fontmake -g sources/Cairo.glyphs -i "Cairo Regular" --verbose ERROR
  fontmake -g sources/Cairo.glyphs -i "Cairo SemiBold" --verbose ERROR
  fontmake -g sources/Cairo.glyphs -i "Cairo Bold" --verbose ERROR
  fontmake -g sources/Cairo.glyphs -i "Cairo Black" --verbose ERROR
  fontmake -g sources/Cairo.glyphs -i "Cairo ExtraBlack" --verbose ERROR
  #fontmake -g sources/Cairo-Italic.glyphs -i "Cairo ExtraLight Italic" --verbose INFO
  #fontmake -g sources/Cairo-Italic.glyphs -i "Cairo Light Italic" --verbose INFO
  #fontmake -g sources/Cairo-Italic.glyphs -i "Cairo Italic" --verbose INFO
  #fontmake -g sources/Cairo-Italic.glyphs -i "Cairo SemiBold Italic" --verbose INFO
  #fontmake -g sources/Cairo-Italic.glyphs -i "Cairo Bold Italic" --verbose INFO
fi

if [ "$build_static_fonts" = true ]; then
  echo "[INFO] Moving static fonts"
  for font in instance_ttf/Cairo-*; do
    echo "[INFO] Moving $font ..."
    mv $font fonts/ttf/
  done
fi

echo "[INFO] Removing build directories"
rm -rf instance_ufo instance_otf instance_ttf master_ufo

echo "[INFO] Fixing VF DSIG tables"
for sources in $glyphs_source; do
  if gftools fix-dsig -f fonts/vf/$sources-VF.ttf >/dev/null; then
    echo "[INFO] DSIG fixed for $sources-VF.ttf"
  else
    echo "[ERROR] GFtools is not working, please update or install: https://github.com/googlefonts/gftools"
  fi
done

if [ "$build_static_fonts" = true ]; then
  echo "[INFO] Fixing Static DSIG tables"
  for font in fonts/ttf/Cairo-*; do
    echo "[INFO] Fixing DSIG table for $font ..."
    gftools fix-dsig -f $font >/dev/null
  done
fi

if [ "$autohint" = true ]; then
  echo "[INFO] Autohinting variable fonts with ttfautohint"
  for font in fonts/vf/Cairo-*; do
    echo "[INFO] Hinting $font ";
    ttfautohint $font temp.ttf
    mv temp.ttf $font
    gftools fix-hinting $font
    mv $font.fix $font
  done
fi

if [ "$build_static_fonts" = true ] && [ "$autohint" = true ]; then
  echo "[INFO] Autohinting static fonts with ttfautohint"
  for font in fonts/ttf/Cairo-*; do
    echo "[INFO] Hinting $font ";
    ttfautohint $font temp.ttf
    mv temp.ttf $font
    gftools fix-hinting $font
    mv $font.fix $font
  done
fi

if [ "$nohinting" = true ]; then
  for font in fonts/vf/Cairo-*; do
    echo "[INFO] Fixing nonhinting for $font ";
    gftools fix-nonhinting $font fonts/vf/temp.ttf >/dev/null
    mv fonts/vf/temp.ttf $font
    rm -rf fonts/vf/*backup-fonttools-prep-gasp.ttf
  done
fi

if [ "$build_static_fonts" = true ] && [ "$nohinting" = true ]; then
  echo "[INFO] Fixing nonhinting for static fonts"
  for font in fonts/ttf/Cairo-*; do
    echo "[INFO] Fixing nonhinting for $font ";
    gftools fix-nonhinting $font fonts/ttf/temp.ttf >/dev/null
    mv fonts/ttf/temp.ttf $font
    rm -rf fonts/ttf/*backup-fonttools-prep-gasp.ttf
  done
fi

echo "[INFO] Done building $family_name font family"
