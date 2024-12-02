# shellcheck shell=bash

shellfiles=("secrets.sh" "vars.sh" "$(hostname).vars.sh" "paths.sh" "$(hostname).paths.sh" "aliases.sh" "$(hostname).aliases.sh")
for file in "${shellfiles[@]}"; do
  [[ -n $SHELL_DEBUG ]] && echo "DEBUG: Sourcing $file"
  [ -s "$SHELLDOTDIR/$file" ] && source "$SHELLDOTDIR/$file"
done