#!/bin/bash
set -e
# This script builds Cairo's variable and static fonts.
# It contains all the steps needed to build new fonts,
# so font builds are repeatable and documented.
#
# To build new fonts, open a Unix-like terminal, navigate to
# the Cairo source root directory, and run the script:
#
# $ sh scripts/build.sh
#
# Also, if you are updating the font for Google Fonts, you can
# run an additional pull-request-helper script as well.
# Just remember to change the "prDir" file path variable
# if you aren't building to ~/Google/fonts/ofl/.../:
#
# $ sh scripts/build.sh && scripts/google-fonts-pr.sh
#
# The default settings should produce output that will conform
# to the Google Fonts Spec [1] and pass all FontBakery QA Tests [2].
# However, the Build Script Settings below are designed to be easily
# modified for other platforms and use cases.
#
# This script requires Python3 [3] and a Unix-like
# environment(Mac, Linux, WSL), with a BASH-like shell.
# All Python dependencies will be installed in a temporary
# virtual environment by the script. Please see the
# Google Fonts Spec [1] and the FontBakery QA Tools [2] for more info.
#
# Script by Eli H. If you have questions, please send an email [4].
#
# [1] https://github.com/googlefonts/gf-docs/tree/master/Spec
# [2] https://pypi.org/project/fontbakery/
# [3] https://www.python.org/
# [4] elih@protonmail.com
#
#########################
# BUILD SCRIPT SETTINGS #
#########################
alias activate_py_venv=". cairo-build/bin/activate"  # Starts a Python 3 VENV when invoked
output_dir="fonts"                                   # Where the output from this script goes
family_name="Cairo"                                  # Font family name for output files
glyphs_source="Cairo-weight-axis-only"               # Change to `Cairo` to build fonts with the `slnt` axis
build_static_fonts=true                              # Set to `true` if you want to build static fonts
autohint=false                                       # Set to `true` if you want to use auto-hinting (ttfautohint)
nohinting=true                                       # Set to `true` if you want the fonts unhinted
make_new_venv=true                                   # Set to `true` if you want to build and activate a python3 venv as part of the script

################
# BUILD SCRIPT #
################
echo "[INFO] Starting build script for $family_name font family"

if [ -d .git ]; then
  echo "[TEST] Running from a Git root directory, looks good"
else
  echo "[WARN] Font family Git root not found, please run from the root directory"
  echo "[WARN] Build process cancelled"
  exit 1
fi

if [ "$make_new_venv" = true ]; then
  echo "[INFO] Building a new Python3 virtual environment"
  python3 -m venv cairo-build
  echo "[INFO] Activating the Python3 virtual environment"
  activate_py_venv
  echo "[INFO] Python3 setup..."
  which python
  pip install --upgrade pip
  pip install --upgrade -r requirements.txt
  echo "[INFO] Done with Python3 virtual environment setup"
fi

for sources in $glyphs_source; do
  echo "[TEST] Queued source file: $sources.glyphs"
done

for sources in $glyphs_source; do
  echo "[INFO] Building $sources.glyphs VFs with Fontmake..."
  fontmake -g sources/$sources.glyphs -o variable \
    --output-path $output_dir/vf/Cairo-VF.ttf \
    --verbose ERROR
done

if [ "$build_static_fonts" = true ]; then
  echo "[INFO] Building static fonts"
  fontmake -g sources/Cairo-weight-axis-only.glyphs -i "Cairo ExtraLight" --verbose ERROR
  fontmake -g sources/Cairo-weight-axis-only.glyphs -i "Cairo Light" --verbose ERROR
  fontmake -g sources/Cairo-weight-axis-only.glyphs -i "Cairo Regular" --verbose ERROR
  fontmake -g sources/Cairo-weight-axis-only.glyphs -i "Cairo SemiBold" --verbose ERROR
  fontmake -g sources/Cairo-weight-axis-only.glyphs -i "Cairo Bold" --verbose ERROR
  fontmake -g sources/Cairo-weight-axis-only.glyphs -i "Cairo Black" --verbose ERROR
  fontmake -g sources/Cairo-weight-axis-only.glyphs -i "Cairo ExtraBlack" --verbose ERROR
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
if gftools fix-dsig -f fonts/vf/$family_name-VF.ttf >/dev/null; then
  echo "[INFO] DSIG fixed for $sources-VF.ttf"
else
  echo "[ERROR] GFtools is not working, please update or install: https://github.com/googlefonts/gftools"
fi

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
