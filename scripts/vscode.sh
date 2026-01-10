#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"

# 1. Define profiles and their files using parallel arrays (for Bash 3.2 compatibility)
PROFILE_IDS=("4a9f917b" "1a6df7f5")
PROFILE_FILES=("profiles/frontend/settings.json" "profiles/node/settings.json")

echo "Setting up VSCode..."

# --- General Settings Setup ---
# Create VSCode user directory if it doesn't exist
mkdir -p "$VSCODE_USER_DIR"

# Backup existing settings.json if it's a regular file and not a symlink
if [[ -f "$VSCODE_USER_DIR/settings.json" && ! -L "$VSCODE_USER_DIR/settings.json" ]]; then
    echo "Backing up existing general settings.json"
    mv "$VSCODE_USER_DIR/settings.json" "$VSCODE_USER_DIR/settings.json.backup"
fi

# Remove existing file/link and create symlink to the general settings
rm -f "$VSCODE_USER_DIR/settings.json"
ln -s "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
echo "  Linked general settings.json"

# --- VSCode Profiles Setup ---
# Iterate using the index of the arrays
for i in "${!PROFILE_IDS[@]}"; do
    PROFILE_ID="${PROFILE_IDS[$i]}"
    SETTING_FILE="${PROFILE_FILES[$i]}"
    
    PROFILE_PATH="$VSCODE_USER_DIR/profiles/$PROFILE_ID"
    SOURCE_PATH="$DOTFILES_DIR/vscode/$SETTING_FILE"

    echo "Processing profile: $PROFILE_ID (using $SETTING_FILE)..."

    # Check if the source settings file exists in dotfiles
    if [[ ! -f "$SOURCE_PATH" ]]; then
        echo "    Error: Source file $SOURCE_PATH not found. Skipping..."
        continue
    fi

    # Ensure the profile directory exists
    mkdir -p "$PROFILE_PATH"

    # Backup existing settings in the profile if it's not a symlink
    if [[ -f "$PROFILE_PATH/settings.json" && ! -L "$PROFILE_PATH/settings.json" ]]; then
        echo "    Backing up existing settings.json in profile $PROFILE_ID"
        mv "$PROFILE_PATH/settings.json" "$PROFILE_PATH/settings.json.backup"
    fi

    # Remove existing file/link and link the specific settings file
    rm -f "$PROFILE_PATH/settings.json"
    ln -s "$SOURCE_PATH" "$PROFILE_PATH/settings.json"
    
    echo "    Linked $SETTING_FILE to profile $PROFILE_ID"
done

echo "VSCode setup complete!"