#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 ~/path/to/config"
    echo "Example: $0 ~/.config/kitty"
    exit 1
fi

# Convert to absolute path and remove trailing slash
CONFIG_PATH=$(realpath "$1")

# Get the path relative to home directory
REL_PATH="${CONFIG_PATH#$HOME/}"

# Check if path is actually in home directory
if [[ "$CONFIG_PATH" != "$HOME"* ]]; then
    echo "Error: Path must be within home directory ($HOME)"
    exit 1
fi

# Create the directory structure in dotfiles
mkdir -p "$HOME/dotfiles/$(dirname "$REL_PATH")"

# Check if path already exists in dotfiles
if [ -e "$HOME/dotfiles/$REL_PATH" ]; then
    echo "Warning: Path already exists in dotfiles"
    read -p "Do you want to overwrite? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
    rm -rf "$HOME/dotfiles/$REL_PATH"
fi

# Move the config to dotfiles
echo "Moving $CONFIG_PATH to dotfiles..."
mv "$CONFIG_PATH" "$HOME/dotfiles/$REL_PATH"

# Restow
echo "Updating symlinks..."
cd "$HOME/dotfiles"
stow -R .

echo "Done! Added $REL_PATH to dotfiles"