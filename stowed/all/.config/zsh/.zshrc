#! /usr/bin/env zsh

[ -s $HOME/.secrets ] && source $HOME/.secrets
source $HOME/.paths
source $HOME/.aliases
source $HOME/.functions

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

