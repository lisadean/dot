#!/bin/bash -x

cd "$DOTFILES"
mkdir -p "$HOME/.config/shell/zsh"
touch "$HOME/.config/shell/zsh/.placeholder"
stow_dirs=("stow-home" "stow-shell" "stow-ssh" "stow-git" "stow-1password" "stow-bin")
for dir in "${stow_dirs[@]}"; do
  stow -R "$dir"
done