#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ghostty config lives at ~/.config/ghostty/config (XDG)
CONFIG_LINK="$(readlink "$HOME/.config" 2>/dev/null || true)"
if [[ "$CONFIG_LINK" == "dotfiles/.config" || "$CONFIG_LINK" == "$DOTFILES_DIR/.config" ]]; then
  : # ~/.config already points at dotfiles; nothing to link
else
  mkdir -p "$HOME/.config"
  ln -sfn "$DOTFILES_DIR/.config/ghostty" "$HOME/.config/ghostty"
fi

if [[ "${1:-}" == "--brew" ]]; then
  xargs brew install <"$DOTFILES_DIR/brew.txt"
fi
