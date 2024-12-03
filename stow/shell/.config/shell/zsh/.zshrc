# shellcheck shell=bash
# export SHELL_DEBUG=1

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(git nvm direnv)
ZSH_THEME="robbyrussell"
[[ -n $SHELL_DEBUG ]] && echo "DEBUG: Sourcing Oh My Zsh"
[ -s "$ZSH/oh-my-zsh.sh" ] && source $ZSH/oh-my-zsh.sh

# source shared shell vars, paths and aliases
[[ -n $SHELL_DEBUG ]] && echo "DEBUG: Sourcing source.sh"
[ -s "$SHELLDOTDIR/source.sh" ] && source "$SHELLDOTDIR/source.sh"

[[ -n $SHELL_DEBUG ]] && echo "DEBUG: Sourcing nvm.sh"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

if command -v pyenv 1>/dev/null 2>&1; then
  [[ -n $SHELL_DEBUG ]] && echo "DEBUG: Running pyenv init"
  eval "$(pyenv init -)"
fi

[[ -n $SHELL_DEBUG ]] && echo "DEBUG: Sourcing sdkman-init.sh"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# direnv extension hook
if command -v direnv 1>/dev/null 2>&1; then
  [[ -n $SHELL_DEBUG ]] && echo "DEBUG: Running direnv hook"
  eval "$(direnv hook zsh)"
fi

# Homebrew path & vars
[[ -n $SHELL_DEBUG ]] && echo "DEBUG: Running brew shellenv"
eval "$(/opt/homebrew/bin/brew shellenv)"