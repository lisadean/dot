# shellcheck shell=bash

[[ -s ~/bin/$(uname -m) ]] && export PATH=~/bin/$(uname -m):$PATH
[[ -s ~/bin/$(hostname) ]] && export PATH=~/bin/$(hostname):$PATH
export PATH=~/bin:$PATH
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH" # VSCode command line
export PATH="/usr/local/opt/openjdk/bin:$PATH" # OpenJDK
export PATH=$HOME/.docker/bin:$PATH # Docker CLI
export PATH="$PYENV_ROOT/bin:$PATH" # Pyenv
