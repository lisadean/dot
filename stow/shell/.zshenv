# shellcheck shell=bash

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}
export SHELLDOTDIR=${SHELLDOTDIR:=${XDG_CONFIG_HOME}/shell}
export ZDOTDIR=${ZDOTDIR:=${SHELLDOTDIR}/zsh}
