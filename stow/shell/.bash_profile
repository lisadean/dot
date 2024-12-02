#! /usr/bin/bash -x

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}
export SHELLDOTDIR=${SHELLDOTDIR:=${XDG_CONFIG_HOME}/shell}
export BASHDOTDIR=${BASHDOTDIR:=${SHELLDOTDIR}/bash}

# source shared shell vars, paths and aliases
[ -s "$SHELLDOTDIR/source.sh" ] && source "$SHELLDOTDIR/source.sh"

bashfiles=("function.sh" "prompt.sh")
for file in "${bashfiles[@]}"; do
  [ -s "$BASHDOTDIR/$file" ] && source "$BASHDOTDIR/$file"
done

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# direnv extension hook
if command -v direnv 1>/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi
