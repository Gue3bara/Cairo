#!/bin/bash
set -e

build_static_fonts=true

prDir="~/Google/fonts/ofl/cairo"  # Edit this path to whatever works best on your system
familyName="Cairo"

echo "[INFO] Preparing a new $familyName pull request at $prDir"

echo "[INFO] Moving variable fonts"
cp fonts/vf/Cairo-VF.ttf ~/Google/fonts/ofl/cairo/Cairo[wght].ttf

echo "[INFO] Moving Static fonts"
cp fonts/ttf/Cairo-Black.ttf ~/Google/fonts/ofl/cairo/static/
cp fonts/ttf/Cairo-Bold.ttf ~/Google/fonts/ofl/cairo/static/
cp fonts/ttf/Cairo-ExtraBlack.ttf ~/Google/fonts/ofl/cairo/static/
cp fonts/ttf/Cairo-ExtraLight.ttf ~/Google/fonts/ofl/cairo/static/
cp fonts/ttf/Cairo-Light.ttf ~/Google/fonts/ofl/cairo/static/
cp fonts/ttf/Cairo-Regular.ttf ~/Google/fonts/ofl/cairo/static/
cp fonts/ttf/Cairo-SemiBold.ttf ~/Google/fonts/ofl/cairo/static/

echo "[INFO] Done preparing $familyName pull request at $prDir"
