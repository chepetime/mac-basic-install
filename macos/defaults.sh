#!/usr/bin/env bash
# macOS settings. Safe to run more than once. No sudo.
# Some changes need a logout to take full effect.
set -euo pipefail

echo "Keyboard and text"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Trackpad and mouse"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false   # natural scrolling off
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true       # tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "Dock"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 55
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mineffect -string scale

echo "Desktop and windows"
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false  # click wallpaper does not hide windows
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false          # no gaps between tiled windows

echo "Finder"
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv        # list view
defaults write com.apple.finder FXDefaultSearchScope -string SCcf        # search the current folder
defaults write com.apple.finder NewWindowTarget -string PfHm             # new window opens home
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "Screenshots"
mkdir -p "$HOME/Documents/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Documents/Screenshots"

echo "Restarting Dock, Finder, and SystemUIServer"
for app in Dock Finder SystemUIServer; do killall "$app" >/dev/null 2>&1 || true; done
echo "Done."
