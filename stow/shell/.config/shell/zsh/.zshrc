# shellcheck shell=bash
# export SHELL_DEBUG=1

# Homebrew path & vars
# Needs to be before any brew installed apps or they won't be found (I'm looking at you direnv)
[[ -n $SHELL_DEBUG ]] && echo "DEBUG: Running brew shellenv"
eval "$(/opt/homebrew/bin/brew shellenv)"

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

if command -v rbenv 1>/dev/null 2>&1; then
  [[ -n $SHELL_DEBUG ]] && echo "DEBUG: Running rbenv init"
  eval "$(rbenv init - --no-rehash zsh)"
fi

# direnv extension hook
if command -v direnv 1>/dev/null 2>&1; then
  [[ -n $SHELL_DEBUG ]] && echo "DEBUG: Running direnv hook"
  eval "$(direnv hook zsh)"
fi

# fnm -- must be after Homebrew initialization
if command -v fnm 1>/dev/null 2>&1; then
  [[ -n $SHELL_DEBUG ]] && echo "DEBUG: Running fnm init"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# SDKMAN -- must be after Homebrew initialization
[[ -n $SHELL_DEBUG ]] && echo "DEBUG: Sourcing sdkman-init.sh"
export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"
