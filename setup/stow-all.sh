#!/bin/bash -x

export STOW_DIR="$DOTFILES/stow"
export STOW_OPTIONS='--no-folding --verbose'
export STOW_ACTION='-R' # -S --stow, -R --restow, -D --delete

stow "$STOW_OPTIONS" -t "$HOME" $STOW_ACTION shell
stow "$STOW_OPTIONS" -t "$HOME" $STOW_ACTION git
stow "$STOW_OPTIONS" -t "$HOME" $STOW_ACTION 1password
stow "$STOW_OPTIONS" -t "$HOME" $STOW_ACTION ssh
stow "$STOW_OPTIONS" -t "$HOME" $STOW_ACTION docker
stow "$STOW_OPTIONS" -t "/opt/datadog-agent/etc" $STOW_ACTION datadog