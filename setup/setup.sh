#!/bin/bash -x

#  Run with
#  curl -L https://raw.githubusercontent.com/lisadean/dot/main/setup/setup.sh | bash

echo "Login to App Store & iCloud (press any key to continue)"
read -r anykey

sudo -v

# Clone dotfiles
mkdir -p "$HOME/dot"
DOTFILES="$HOME/dot"
[ ! -s "$DOTFILES/.git/HEAD" ] && git clone https://github.com/lisadean/dot.git "$DOTFILES"

# chsh -s /bin/zsh

source "$DOTFILES/setup/setup-step2.sh"