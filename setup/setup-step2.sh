#!/bin/bash -x

export MOVE_CONFIG=$(mv ~/.config/git/config ~/.config/git/config.bak)
export MOVE_CONFIG_BACK=$(mv ~/.config/git/config.bak ~/.config/git/config)

# Install homebrew and dependencies
sudo softwareupdate --install-rosetta --agree-to-license
xcode-select --install
sudo xcodebuild -license accept
if ! command -v brew 1>/dev/null 2>&1; then
  $MOVE_CONFIG
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/opt/homebrew/bin/brew shellenv)"
  $MOVE_CONFIG_BACK
fi

# Install stow and stow files
brew install stow
source "$DOTFILES/setup/stow-all.sh"

##### App installs #####

# oh-my-zsh
$MOVE_CONFIG
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$MOVE_CONFIG_BACK

# nvm
if ! command -v nvm 1>/dev/null 2>&1; then
  $MOVE_CONFIG
  PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'
  $MOVE_CONFIG_BACK
fi
export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install --lts

brews=(
  bat
  direnv
  fzf
  gh
  git
  jq
  mas
  pyenv
  ripgrep
  tldr
  tmux
  tree
)
casks=(
  1password
  datadog-agent
  ddpm
  discord
  disk-expert
  docker
  dropbox
  firefox
  github
  google-chrome
  google-drive
  homebrew/cask-fonts/font-fira-code
  keyclu
  logi-options+
  postman
  raindropio
  rectangle-pro
  slack
  spotify
  visual-studio-code
  whatsapp
)
mas_apps=(
  1091189122 # Bear
  1569813296 # 1Password for Safari
  497799835 # Xcode
)
# npm_packages=()
brew install "${brews[@]}"
brew install --cask "${casks[@]}"
mas install "${mas_apps[@]}"
# npm install -g "${npm_packages[@]}"

##### Mac settings #####

# https://github.com/ChristopherA/dotfiles-stow/blob/master/5-macos/.install/macos-setup.d/macos-setup-matthias
# https://github.com/makccr/dot/blob/master/.scripts/macOS
# Set Spotlight search options
# Change indexing order and disable some search results
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 1;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}' \
	'{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null
# Make mouse cursor one size bigger
defaults write com.apple.universalaccess mouseDriverCursorSize -float 1.5
# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
# Disable "natural" (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true
# Stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null
# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
#Arranges Finder by Name By Default
defaults write com.apple.finder FXArrangeGroupViewBy -string "Name"
# Show the ~/Library folder
chflags nohidden ~/Library
# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true
  # Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 62
# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array
# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0
# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
#Turns of Dock Magnification
defaults write com.apple.dock magnification -bool false
# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5
# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0
# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true
# Use the system-native print preview dialog
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true
# Expand the print dialog by default
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true
#Moves Folders to top When Sorting Alphabetically in Finder 
defaults write com.apple.finder _FXSortFoldersFirst -bool true
for app in "Activity Monitor" "cfprefsd" "Dock" "Finder" "Photos" "Safari" "Google Chrome" "SystemUIServer" "Terminal"; do
	killall "${app}" &> /dev/null
done

echo "Copy secrets file to ~/.config/shell/secrets"

# Primeagean stuff
# https://github.com/ThePrimeagen/dev/blob/master/env/.zshrc

# TODO take care of stow-datadog > /opt/datadog-agent/etc/datadog.yaml
# TODO take care of stow-docker > ~/.docker

# TODO
# find all stashes and deal with them
# copy down repos in correct work/personal location
# set wallpaper