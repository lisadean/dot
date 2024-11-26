#!/bin/bash -x

echo "Login to App Store"
read -r answer

# Clone dotfiles
DOTFILES="$HOME/dot"
git clone https://github.com/lisadean/dot.git "$DOTFILES"

# chsh -s /bin/zsh

# Install homebrew and dependencies
sudo softwareupdate --install-rosetta
xcode-select --install
if ! brew --version ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install stow and stow files
brew install stow
stow_dirs=("stow-home" "stow-shell" "stow-ssh" "stow-git" "stow-1password" "stow-bin")
for dir in "${stow_dirs[@]}"; do
  stow -R "$dir"
done

# App installs
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# nvm
if command -v nvm 1>/dev/null 2>&1; then
  PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'
fi
# brew apps
readarray -t brews < "$DOTFILES/brews.txt"
readarray -t casks < "$DOTFILES/casks.txt"
brew install "${brews[@]}"
brew install -cask "${casks[@]}"
# app store apps
readarray -t mas_apps < "$DOTFILES/mas_apps.txt"
mas install "${mas_apps[@]}"
# npm packages
readarray -t npm_packages < "$DOTFILES/npm_packages.txt"
npm install -g "${npm_packages[@]}"

echo "Copy secrets file to ~/.config/shell/secrets"

# Mac settings
# https://github.com/ChristopherA/dotfiles-stow/blob/master/5-macos/.install/macos-setup.d/macos-setup-matthias