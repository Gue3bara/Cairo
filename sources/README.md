## Building New Fonts from Source
A Bash build script is located in the [scripts](../scripts) directory.
To build new font files, open a Unix(macOS, Linux, WSL, etc) terminal and activate a
[Python3 virtual environment](https://docs.python.org/3/library/venv.html)
with the packages from [requirements.txt](../requirements.txt) installed.
Then, navigate to the root(first level within the directory) of this repository, and run the following:
```
sh scripts/build.sh
```
If you want to make a new pull request to [Google Fonts](https://github.com/google/fonts),
 clone the [git repository](https://github.com/google/fonts)
 to `~/Google/`, and run the following:
```
sh scripts/build.sh && scripts/google-fonts-pr.sh
```
