# shellcheck shell=bash

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(git nvm direnv)
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

# source shared shell vars, paths and aliases
[ -s "$SHELLDOTDIR/source.sh" ] && source "$SHELLDOTDIR/source.sh"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# direnv extension hook
if command -v direnv 1>/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# Homebrew path & vars
eval "$(/opt/homebrew/bin/brew shellenv)"

