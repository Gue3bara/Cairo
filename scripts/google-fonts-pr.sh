#!/bin/bash
set -e

build_static_fonts=true

prDir="~/Google/fonts/ofl/cairo"  # Edit this path to whatever works best on your system
familyName="Cairo"

echo "[INFO] Preparing a new $familyName pull request at $prDir"

echo "[INFO] Moving variable fonts"
cp fonts/vf/Cairo-VF.ttf ~/Google/fonts/ofl/cairo/Cairo[wght].ttf

if [ "$build_static_fonts" = true ]; then
  for font in fonts/ttf/Cairo-*; do
    echo "[INFO] Moving static font $font ";
    cp $font ~/Google/fonts/ofl/cairo/static/
  done
fi

echo "[INFO] Done preparing $familyName pull request at $prDir"
