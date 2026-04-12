# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Dotfiles repo managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory (bash, vim, tmux, git, starship) is a stow "package" — its contents mirror `$HOME` so stow can symlink them into place.

## Commands

```bash
./bootstrap.sh       # Install system packages (apt on Linux, Homebrew on macOS)
./install.sh         # Symlink all packages into $HOME (backs up conflicts to ~/.dotfiles-backup/)
./uninstall.sh       # Remove all symlinks

# Single package
stow -v -t "$HOME" bash        # Stow one package
stow -v -t "$HOME" -D bash     # Unstow one package
```

## Architecture

- **Stow packages**: `bash`, `vim`, `tmux`, `git`, `starship` — defined in the `PACKAGES` array in `install.sh` and `uninstall.sh`. Add new packages to both scripts.
- **Cross-platform**: `bootstrap.sh` and `.bashrc` branch on `uname -s` (Linux vs Darwin). Keep both paths working when making changes.
- **Local overrides**: Machine-specific config goes in `~/.bashrc.local` (sourced at end of `.bashrc`, not tracked).
- **Starship prompt**: Primary prompt; `.bashrc` falls back to a basic PS1 if `starship` isn't installed.
