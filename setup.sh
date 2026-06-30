#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v stow >/dev/null 2>&1; then
  echo "GNU stow is required but not installed. Install it with: brew install stow" >&2
  exit 1
fi

# Symlink every tracked dotfile (honoring .stow-local-ignore) into $HOME.
stow --dir "$(dirname "$DOTFILES_DIR")" \
     --target "$HOME" \
     --restow \
     "$(basename "$DOTFILES_DIR")"

echo "Dotfiles symlinked into $HOME"

if [[ "${1:-}" == "--brew" ]]; then
  echo "Installing Homebrew packages from brew.txt..."
  xargs brew install <"$DOTFILES_DIR/brew.txt"
fi
