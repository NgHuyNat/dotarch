#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "========================================"
echo "    Dotfiles Installation Script"
echo "========================================"

# 1. Install end-4 base dotfiles
echo ""
echo "==> Step 1: Installing end-4 base dotfiles..."
echo "Please follow the interactive prompts for the initial setup."
bash <(curl -s https://ii.clsty.link/get)

# 2. Setup symlinks for .config
echo ""
echo "==> Step 2: Applying custom .config symlinks..."
mkdir -p "$HOME/.config"

for config_dir in "$DOTFILES_DIR/.config"/*; do
    if [ ! -e "$config_dir" ]; then continue; fi
    
    dir_name=$(basename "$config_dir")
    target="$HOME/.config/$dir_name"
    
    # Check if target is already the correct symlink
    if [ -L "$target" ]; then
        current_target=$(readlink -f "$target")
        if [ "$current_target" = "$config_dir" ]; then
            echo " [OK] $dir_name is already correctly symlinked."
            continue
        else
            echo " [BACKUP] $target is a symlink pointing elsewhere. Backing up..."
            mv "$target" "${target}.bak"
        fi
    elif [ -e "$target" ]; then
        echo " [BACKUP] $target exists. Backing up to ${target}.bak..."
        mv "$target" "${target}.bak"
    fi
    
    ln -s "$config_dir" "$target"
    echo " [LINK] Created symlink for $dir_name"
done

# 3. Setup symlinks for home directory
echo ""
echo "==> Step 3: Applying custom home directory symlinks..."

# Find all items in the dotfiles/home directory (including hidden ones)
shopt -s dotglob
for home_file in "$DOTFILES_DIR/home"/*; do
    if [ ! -e "$home_file" ]; then continue; fi
    
    file_name=$(basename "$home_file")
    target="$HOME/$file_name"
    
    # Check if target is already the correct symlink
    if [ -L "$target" ]; then
        current_target=$(readlink -f "$target")
        if [ "$current_target" = "$home_file" ]; then
            echo " [OK] $file_name is already correctly symlinked."
            continue
        else
            echo " [BACKUP] $target is a symlink pointing elsewhere. Backing up..."
            mv "$target" "${target}.bak"
        fi
    elif [ -e "$target" ]; then
        echo " [BACKUP] $target exists. Backing up to ${target}.bak..."
        mv "$target" "${target}.bak"
    fi
    
    ln -s "$home_file" "$target"
    echo " [LINK] Created symlink for $file_name"
done
shopt -u dotglob

# 4. Install extra packages
echo ""
echo "==> Step 4: Installing extra custom packages..."
if [ -x "$DOTFILES_DIR/scripts/install-packages.sh" ]; then
    "$DOTFILES_DIR/scripts/install-packages.sh"
else
    bash "$DOTFILES_DIR/scripts/install-packages.sh"
fi

echo ""
echo "========================================"
echo "    Installation Complete!"
echo "========================================"
