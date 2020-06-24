## Building New Fonts from Source

`../scripts/build.sh` is a script that builds Cairo's variable and static fonts. It contains all the steps needed to build new fonts, so font builds are repeatable and documented.

To build new fonts, open a Unix-like terminal, navigate to the Cairo source root directory, and run the script:
```
sh scripts/build.sh
```
Also, if you are updating the font for Google Fonts, you can run an additional pull-request-helper script as well. Just remember to change the "prDir" file path variable if you aren't building to `~/Google/fonts/ofl/.../`:
```
sh scripts/build.sh && scripts/google-fonts-pr.sh
```
The default settings should produce output that will conform to the [Google Fonts Spec](https://github.com/googlefonts/gf-docs/tree/master/Spec) and pass all [FontBakery QA Tests](https://pypi.org/project/fontbakery/). However, the Build Script Settings are designed to be easily modified for other platforms and use cases.

This script requires [Python3](https://www.python.org/) and a Unix-like environment(Mac, Linux, WSL), with a BASH-like shell. All Python dependencies will be installed in a temporary virtual environment by the script.

Please see the [Google Fonts Spec](https://github.com/googlefonts/gf-docs/tree/master/Spec) and the [FontBakery QA Tests](https://pypi.org/project/fontbakery/) for more info.
