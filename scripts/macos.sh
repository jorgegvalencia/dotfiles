#!/bin/bash
# macOS System Preferences
# Run: ./scripts/macos.sh
# Note: Some settings require logout/restart to take effect

echo "Configuring macOS defaults..."

# Close System Preferences to prevent overriding changes
osascript -e 'tell application "System Preferences" to quit'

# Ask for admin password upfront
sudo -v

# Keep-alive: update sudo timestamp until script finishes
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Disable the sound effects on boot
# sudo nvram SystemAudioVolume=" "
# To revert: sudo nvram -d SystemAudioVolume

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
# To revert: defaults delete NSGlobalDomain NSNavPanelExpandedStateForSaveMode; defaults delete NSGlobalDomain NSNavPanelExpandedStateForSaveMode2

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
# To revert: defaults delete NSGlobalDomain PMPrintingExpandedStateForPrint; defaults delete NSGlobalDomain PMPrintingExpandedStateForPrint2

# Save to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# To revert: defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool true

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true
# To revert: defaults write NSGlobalDomain NSDisableAutomaticTermination -bool false

###############################################################################
# Keyboard                                                                    #
###############################################################################

# Fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# To revert (standard): defaults write NSGlobalDomain KeyRepeat -int 6; defaults write NSGlobalDomain InitialKeyRepeat -int 68

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# To revert: defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# To revert: defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# To revert: defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool true

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
# To revert: defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool true

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# To revert: defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool true

# Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
# To revert: defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool true

###############################################################################
# Trackpad & Mouse                                                            #
###############################################################################

# Enable tap to click
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# To revert: defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false; defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 0

# Enable three-finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
# To revert: defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false

###############################################################################
# Finder                                                                      #
###############################################################################

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# To revert: defaults write NSGlobalDomain AppleShowAllExtensions -bool false

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# To revert: defaults write com.apple.finder ShowStatusBar -bool false

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true
# To revert: defaults write com.apple.finder ShowPathbar -bool false

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# To revert: defaults write com.apple.finder _FXSortFoldersFirst -bool false

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# To revert: defaults write com.apple.finder FXDefaultSearchScope -string "none"

# Disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# To revert: defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# To revert: defaults delete com.apple.desktopservices DSDontWriteNetworkStores; defaults delete com.apple.desktopservices DSDontWriteUSBStores

# Show the ~/Library folder
chflags nohidden ~/Library
# To revert: chflags hidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes
# To revert: sudo chflags hidden /Volumes

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# To revert: defaults write com.apple.finder FXPreferredViewStyle -string "icnv"

###############################################################################
# Dock                                                                        #
###############################################################################

# Set Dock icon size
defaults write com.apple.dock tilesize -int 48
# To revert: defaults write com.apple.dock tilesize -int 64

# Enable Dock auto-hide
defaults write com.apple.dock autohide -bool true
# To revert: defaults write com.apple.dock autohide -bool false

# Remove auto-hide delay
defaults write com.apple.dock autohide-delay -float 0
# To revert: defaults delete com.apple.dock autohide-delay

# Speed up auto-hide animation
defaults write com.apple.dock autohide-time-modifier -float 0.3
# To revert: defaults delete com.apple.dock autohide-time-modifier

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false
# To revert: defaults write com.apple.dock show-recents -bool true

# Minimize windows into their application's icon
defaults write com.apple.dock minimize-to-application -bool true
# To revert: defaults write com.apple.dock minimize-to-application -bool false

###############################################################################
# Safari                                                                      #
###############################################################################

# Show the full URL in the address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
# To revert: defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool false

# Enable Safari's Developer menu and Web Inspector
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# To revert: defaults write com.apple.Safari IncludeDevelopMenu -bool false

###############################################################################
# Terminal                                                                    #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4
# To revert: defaults delete com.apple.terminal StringEncodings

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0
# To revert: defaults write com.apple.ActivityMonitor ShowCategory -int 100

# Sort by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
# To revert: defaults delete com.apple.ActivityMonitor SortColumn; defaults delete com.apple.ActivityMonitor SortDirection

###############################################################################
# Screenshots                                                                 #
###############################################################################

# Save screenshots to Downloads
defaults write com.apple.screencapture location -string "${HOME}/Downloads"
# To revert: defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format
defaults write com.apple.screencapture type -string "png"
# To revert: defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true
# To revert: defaults write com.apple.screencapture disable-shadow -bool false

###############################################################################
# Kill affected applications                                                  #
###############################################################################

echo "Restarting affected applications..."

for app in "Dock" "Finder" "Safari" "SystemUIServer"; do
    killall "${app}" &> /dev/null || true
done

echo "Done! Some changes require a logout/restart to take effect."