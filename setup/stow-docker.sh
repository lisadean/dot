#!/bin/bash -x

export DOTFILES="${DOTFILES:-$HOME/dot}"
export STOW_DIR="$DOTFILES/stow"
export STOW_OPTIONS="--no-folding"
export STOW_ACTION='-D' # -S --stow, -R --restow, -D --delete

stow $STOW_OPTIONS -d "$STOW_DIR" -t "$HOME" $STOW_ACTION docker
