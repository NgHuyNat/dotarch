#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

PACMAN_LIST="$DOTFILES_DIR/packages/pacman.txt"
AUR_LIST="$DOTFILES_DIR/packages/aur.txt"

echo "==> Installing packages from dotfiles..."

if [[ -f "$PACMAN_LIST" ]]; then
  echo "==> Installing pacman packages..."
  # Try to install all at once for speed
  if ! grep -vE '^\s*#|^\s*$' "$PACMAN_LIST" | xargs -r sudo pacman -S --needed --noconfirm; then
    echo " [WARNING] Bulk pacman install failed. Attempting to install packages individually..."
    for pkg in $(grep -vE '^\s*#|^\s*$' "$PACMAN_LIST"); do
      sudo pacman -S --needed --noconfirm "$pkg" || echo " [WARNING] Failed to install $pkg. Skipping..."
    done
  fi
else
  echo "Pacman package list not found: $PACMAN_LIST"
fi

AUR_HELPER=""

if command -v paru >/dev/null 2>&1; then
  AUR_HELPER="paru"
elif command -v yay >/dev/null 2>&1; then
  AUR_HELPER="yay"
fi

if [[ -f "$AUR_LIST" ]]; then
  if [[ -n "$AUR_HELPER" ]]; then
    echo "==> Installing AUR packages with $AUR_HELPER..."
    for pkg in $(grep -vE '^\s*#|^\s*$' "$AUR_LIST"); do
      "$AUR_HELPER" -S --needed --noconfirm "$pkg" || echo " [WARNING] Failed to install $pkg (it might have been removed from AUR). Skipping..."
    done
  else
    echo "==> No AUR helper found."
    echo "Please install yay or paru first."
    echo "AUR packages skipped."
  fi
else
  echo "AUR package list not found: $AUR_LIST"
fi

echo "==> Done."
