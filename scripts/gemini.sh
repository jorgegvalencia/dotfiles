#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
GEMINI_DIR="$HOME/.gemini"

echo "Setting up Gemini CLI..."

# Create directories if they don't exist
mkdir -p "$GEMINI_DIR"

# Backup and symlink settings.json
if [[ -f "$GEMINI_DIR/settings.json" && ! -L "$GEMINI_DIR/settings.json" ]]; then
    echo "Backing up existing settings.json"
    mv "$GEMINI_DIR/settings.json" "$GEMINI_DIR/settings.json.backup"
fi
rm -f "$GEMINI_DIR/settings.json"
ln -s "$DOTFILES_DIR/gemini/settings.json" "$GEMINI_DIR/settings.json"
echo "  Linked settings.json"

# Backup and symlink bin directory
if [[ -d "$GEMINI_DIR/bin" && ! -L "$GEMINI_DIR/bin" ]]; then
    echo "Backing up existing bin/"
    mv "$GEMINI_DIR/bin" "$GEMINI_DIR/bin.backup"
fi
rm -f "$GEMINI_DIR/bin"
ln -s "$DOTFILES_DIR/gemini/bin" "$GEMINI_DIR/bin"
echo "  Linked bin/"

# Backup and symlink bin directory
if [[ -d "$GEMINI_DIR/skills" && ! -L "$GEMINI_DIR/skills" ]]; then
    echo "Backing up existing skills/"
    mv "$GEMINI_DIR/skills" "$GEMINI_DIR/skills.backup"
fi
rm -f "$GEMINI_DIR/skills"
ln -s "$DOTFILES_DIR/gemini/skills" "$GEMINI_DIR/skills"
echo "  Linked skills/"

# Backup and symlink commands directory
if [[ -d "$GEMINI_DIR/commands" && ! -L "$GEMINI_DIR/commands" ]]; then
    echo "Backing up existing commands/"
    mv "$GEMINI_DIR/commands" "$GEMINI_DIR/commands.backup"
fi
rm -f "$GEMINI_DIR/commands"
ln -s "$DOTFILES_DIR/gemini/commands" "$GEMINI_DIR/commands"
echo "  Linked commands/"

# Backup and symlink agents directory
if [[ -d "$GEMINI_DIR/agents" && ! -L "$GEMINI_DIR/agents" ]]; then
    echo "Backing up existing agents/"
    mv "$GEMINI_DIR/agents" "$GEMINI_DIR/agents.backup"
fi
rm -f "$GEMINI_DIR/agents"
ln -s "$DOTFILES_DIR/gemini/agents" "$GEMINI_DIR/agents"
echo "  Linked agents/"

echo "Gemini CLI setup complete!"