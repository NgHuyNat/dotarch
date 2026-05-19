#!/usr/bin/env bash
set -euo pipefail

home="/home/nghuytan"
dotfiles="$home/.dotfiles"

config_dirs=(
  "hypr"
  "quickshell"
  "nvim"
  "kitty"
)

home_paths=(
  ".zshrc"
  ".p10k.zsh"
  ".tmux.conf"
  ".bashrc"
  ".bash_profile"
  ".bash_logout"
  ".gtkrc-2.0"
)

link_item() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"

  if [ -L "$src" ]; then
    local current_target
    current_target="$(readlink -f "$src")"
    if [ "$current_target" = "$dst" ]; then
      echo "$src is already linked to $dst"
      return
    fi

    echo "Refusing to replace existing symlink: $src -> $current_target" >&2
    return 1
  fi

  if [ ! -e "$src" ]; then
    if [ -e "$dst" ]; then
      ln -s "$dst" "$src"
      echo "Created symlink $src -> $dst"
    else
      echo "Skipping missing source and target: $src"
    fi
    return
  fi

  if [ -e "$dst" ]; then
    echo "Refusing to overwrite existing target: $dst" >&2
    return 1
  fi

  mv "$src" "$dst"
  ln -s "$dst" "$src"
  echo "Moved $src -> $dst and created symlink"
}

mkdir -p "$dotfiles/.config" "$dotfiles/home"

for name in "${config_dirs[@]}"; do
  link_item "$home/.config/$name" "$dotfiles/.config/$name"
done

for path in "${home_paths[@]}"; do
  link_item "$home/$path" "$dotfiles/home/$path"
done

echo "Done."
