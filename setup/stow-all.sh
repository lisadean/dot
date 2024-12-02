#!/bin/bash -x

export DOTFILES="${DOTFILES:-$HOME/dot}"
export STOW_DIR="$DOTFILES/stow"
export STOW_OPTIONS="--no-folding"
export STOW_ACTION='-R' # -S --stow, -R --restow, -D --delete

stow $STOW_OPTIONS -d "$STOW_DIR" -t "$HOME" $STOW_ACTION shell
stow $STOW_OPTIONS -d "$STOW_DIR" -t "$HOME" $STOW_ACTION git
stow $STOW_OPTIONS -d "$STOW_DIR" -t "$HOME" $STOW_ACTION 1password
stow $STOW_OPTIONS -d "$STOW_DIR" -t "$HOME" $STOW_ACTION ssh
stow $STOW_OPTIONS -d "$STOW_DIR" -t "$HOME" $STOW_ACTION docker
sudo stow $STOW_OPTIONS -d "$STOW_DIR" -t /opt $STOW_ACTION datadog