#!/bin/bash

echo "Installing xcode CLI, rosetta and accepting licenses"
if ! command -v xcode-select 1>/dev/null 2>&1; then
  xcode-select --install
fi
sudo softwareupdate --install-rosetta --agree-to-license

echo "Installing homebrew, if needed"
if ! command -v brew 1>/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install stow and stow shell files
echo "Installing stow and stowing shell files"
brew install stow
export DOTFILES="${DOTFILES:-$HOME/dot}"
export STOW_DIR="$DOTFILES/stow"
export STOW_OPTIONS="--no-folding"
export STOW_ACTION='-R' # -S --stow, -R --restow, -D --delete
stow $STOW_OPTIONS -d "$STOW_DIR" -t "$HOME" $STOW_ACTION shell

echo "Installing ohmyzsh"
export ZSH="$HOME/.oh-my-zsh"
if [ ! -s "$ZSH/oh-my-zsh.sh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Installing nvm, if needed"
if ! command -v nvm 1>/dev/null 2>&1; then
  PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'
fi

echo "Installing latest version of Node"
export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts


taps=(
  sdkman/tap
)
brews=(
  bat
  direnv
  fzf
  gh
  git
  jq
  mas
  parallel
  pyenv
  ripgrep
  tldr
  tmux
  tree
  sdkman-cli
  ngrok
  httpyac
  # start python build dependencies
  openssl
  readline
  sqlite3
  xz
  zlib
  tcl-tk@8
  # stop python build dependencies
)
casks=(
  1password
  datadog-agent
  ddpm
  discord
  docker
  dropbox
  firefox
  github
  google-chrome
  google-drive
  figma
  font-fira-code
  keyclu
  logi-options+
  parallels
  postman
  raindropio
  raycast
  rectangle-pro
  slack
  spotify
  visual-studio-code
  whatsapp
)
echo "Installing homebrew packages"
for tap in "${taps[@]}"; do
  brew tap "$tap" || echo "===> 🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨 Failed to tap $formula"
done
for formula in "${brews[@]}"; do
  brew install "$formula" || echo "===> 🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨 Failed to install $formula"
done
for formula in "${casks[@]}"; do
  brew install --cask "$formula" || echo "🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨 Failed to install $formula"
done

mas_apps=(
  1091189122 # Bear
  1569813296 # 1Password for Safari
  497799835 # Xcode
  904280696 # Things 3
  446243721 # Disk Space Analyzer
  1303222628 # Paprika Recipe Manager 3
)
echo "Installing App Store Apps"
for app in "${mas_apps[@]}"; do
  mas install "$app" || echo "🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨 Failed to install $app"
done

echo "Accepting xcode license"
sudo xcodebuild -license accept

echo "Installing Java"
export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"
sdk install java 11.0.22-tem

# Disable IPv6 on wireless network -- prevents ERR_CONNECTION_RESET
# and ERR_SOCKET_NOT_CONNECTED errors in Chrome when on VPN
echo "Disabling IPv6"
networksetup -setv6off Wi-Fi

source "$DOTFILES/setup/stow-all.sh"

echo " 🎉 DONE 🎉"
echo "Postinstall tasks:"
echo "✅ Open 1Password, sign-in and turn on SSH agent Setup > Developer > SSH Agent"
echo "✅ Copy secrets file to ~/.config/shell/secrets"
echo "✅ Run setup-mac.sh for Mac settings (or manually make changes)"
echo "✅ Optional: install python via pyenv install 3.10.4"
echo "✅ Reboot"

# Primeagean stuff
# https://github.com/ThePrimeagen/dev/blob/master/env/.zshrc

# TODO take care of stow-datadog > /opt/datadog-agent/etc/datadog.yaml
# TODO take care of stow-docker > ~/.docker
