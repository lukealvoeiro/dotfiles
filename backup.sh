#!/usr/bin/env bash
set -euo pipefail

# Regenerate the list of explicitly-installed Homebrew packages.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

brew leaves >"$DOTFILES_DIR/brew.txt"
echo "Wrote $(wc -l <"$DOTFILES_DIR/brew.txt" | tr -d ' ') packages to $DOTFILES_DIR/brew.txt"
