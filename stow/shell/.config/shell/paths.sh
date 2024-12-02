# shellcheck shell=bash

[[ -s $HOME/bin/$(uname -m) ]] && export PATH=$HOME/bin/$(uname -m):$PATH
[[ -s $HOME/bin/$(hostname) ]] && export PATH=$HOME/bin/$(hostname):$PATH
export PATH=$DOTFILES/bin:/usr/local/bin:$PATH
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH" # VSCode command line
export PATH="/usr/local/opt/openjdk/bin:$PATH" # OpenJDK
export PATH=$HOME/.docker/bin:$PATH # Docker CLI
export PATH="$PYENV_ROOT/bin:$PATH" # Pyenv
