#!/bin/bash -x

#  Run with
#  curl -L https://raw.githubusercontent.com/lisadean/dot/main/setup/setup.sh | bash

read -p "Login to App Store & iCloud before continuing. Press any key when done" anykey

sudo -v

# Clone dotfiles
mkdir -p "$HOME/dot"
DOTFILES="$HOME/dot"
[ ! -s "$DOTFILES/.git/HEAD" ] && git clone https://github.com/lisadean/dot.git "$DOTFILES"

# chsh -s /bin/zsh

# Everything else is in a seperate script because GitHub caches files in raw.githubusercontent.com
# and might not pull the latest version through curl
source "$DOTFILES/setup/setup-step2.sh"
