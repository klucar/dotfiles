#!/usr/bin/env bash
#
# uninstall.sh - Remove stow symlinks
#
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

PACKAGES=(bash vim tmux git starship kitty)

echo "Unstowing dotfiles..."

for pkg in "${PACKAGES[@]}"; do
    if [ -d "$pkg" ]; then
        echo "  Unstowing: $pkg"
        stow -v -t "$HOME" -D "$pkg"
    fi
done

echo ""
echo "Done. Symlinks removed."
echo "Your backup files (if any) are in ~/.dotfiles-backup/"
