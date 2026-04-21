#!/usr/bin/env bash
#
# install.sh - Symlink dotfiles into $HOME using GNU Stow
#
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

# Packages to stow (each directory at the top level)
PACKAGES=(bash vim tmux git starship kitty gh)

echo "========================================"
echo "  Dotfiles Install (GNU Stow)"
echo "========================================"
echo ""
echo "Dotfiles directory: $DOTFILES_DIR"
echo "Target directory:   $HOME"
echo ""

# Check for stow
if ! command -v stow &>/dev/null; then
    echo "ERROR: GNU Stow is not installed."
    echo "Run ./bootstrap.sh first, or install stow manually:"
    echo "  Linux: sudo apt-get install stow"
    echo "  macOS: brew install stow"
    exit 1
fi

# Back up any existing files that would conflict
backup_dir="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"
conflicts_found=false

for pkg in "${PACKAGES[@]}"; do
    if [ -d "$pkg" ]; then
        # Unstow first so any existing stow symlinks (including tree-folded
        # parent-dir symlinks) are removed. Without this, a file target like
        # ~/.config/kitty/kitty.conf can resolve *through* a folded parent
        # symlink back into this repo, and the backup step below will
        # incorrectly move the repo's own file into the backup dir.
        stow -t "$HOME" -D "$pkg" 2>/dev/null || true

        # Find real (non-symlink) files that stow would create and back them up.
        while IFS= read -r -d '' file; do
            rel="${file#$pkg/}"
            target="$HOME/$rel"
            if [ -e "$target" ] && [ ! -L "$target" ]; then
                conflicts_found=true
                mkdir -p "$backup_dir/$(dirname "$rel")"
                echo "  Backing up: ~/$rel -> $backup_dir/$rel"
                mv "$target" "$backup_dir/$rel"
            fi
        done < <(find "$pkg" -type f -print0)
    fi
done

if [ "$conflicts_found" = true ]; then
    echo ""
    echo "Existing files backed up to: $backup_dir"
    echo ""
fi

# Stow each package
for pkg in "${PACKAGES[@]}"; do
    if [ -d "$pkg" ]; then
        echo "Stowing: $pkg"
        stow -v -t "$HOME" "$pkg"
    else
        echo "Skipping: $pkg (directory not found)"
    fi
done

echo ""
echo "Done! Dotfiles are symlinked."
echo "Restart your shell or run: source ~/.bashrc"
