#!/usr/bin/env bash
set -euo pipefail

# Symlink all dotfiles into $HOME via GNU stow, honoring .stow-local-ignore.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v stow >/dev/null 2>&1; then
  echo "GNU stow is required. Install it (e.g. 'brew install stow') and re-run." >&2
  exit 1
fi

stow --dir="$DOTFILES_DIR" --target="$HOME" --restow .

if [[ "${1:-}" == "--brew" ]]; then
  xargs brew install <"$DOTFILES_DIR/brew.txt"
fi
