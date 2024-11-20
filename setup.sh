#!/usr/bin/env bash

xcode-select --install
if ! brew --version ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install stow