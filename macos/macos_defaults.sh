#!/usr/bin/env bash
osascript -e 'tell application "System Preferences" to quit'


# Sets reasonable macOS defaults.
# Copied from a bunch of places.
# Run ./macos_defaults.sh and you'll be good to go (hopefully).

# Ask for the administrator password upfront
sudo -v

# Set standby delay to 24 hours (default is 1 hour).
sudo pmset -a standbydelay 86400

# Set highlight color to purple.
defaults write NSGlobalDomain AppleHighlightColor -string "0.968627 0.831373 1.000000"

# Always show scrollbars (or not - not sure I like this).
# defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false


# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1


# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3


# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0


# Show the ~/Library folder.
chflags nohidden ~/Library

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1

