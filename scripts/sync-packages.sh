#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

PACMAN_LIST="$DOTFILES_DIR/packages/pacman.txt"
AUR_LIST="$DOTFILES_DIR/packages/aur.txt"

echo "==> Syncing installed packages to dotfiles..."

mkdir -p "$DOTFILES_DIR/packages"

echo "==> Exporting pacman packages..."
pacman -Qqe | grep -vxFf <(pacman -Qqm) >"$PACMAN_LIST"

echo "==> Exporting AUR packages..."
pacman -Qqm >"$AUR_LIST"

echo "==> Done."
echo "Pacman packages saved to: $PACMAN_LIST"
echo "AUR packages saved to: $AUR_LIST"
