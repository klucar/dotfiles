# dotfiles

My dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

```bash
# Clone the repo
git clone https://github.com/klucar/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install system packages (Linux apt or macOS Homebrew)
./bootstrap.sh

# Symlink dotfiles into ~
./install.sh
```

## What's Included

| Package | Files | Description |
|---------|-------|-------------|
| `bash`  | `.bashrc`, `.bash_profile`, `.bash_aliases`, `.bash_logout`, `.inputrc` | Shell config with cross-platform support |
| `vim`   | `.vimrc` | Vim config with sane defaults |
| `tmux`  | `.tmux.conf` | Tmux with C-a prefix, vim keys, mouse support |
| `git`   | `.gitconfig`, `.gitignore_global` | Git config with aliases |
| `starship` | `.config/starship.toml` | [Starship](https://starship.rs/) cross-shell prompt |

## How It Works

Each top-level directory is a stow "package" that mirrors your home directory structure. Running `stow bash` from the dotfiles directory creates symlinks:

```
~/dotfiles/bash/.bashrc  -->  ~/.bashrc
~/dotfiles/vim/.vimrc    -->  ~/.vimrc
```

## Managing

```bash
# Install all packages
./install.sh

# Remove all symlinks
./uninstall.sh

# Stow a single package
cd ~/dotfiles && stow bash

# Unstow a single package
cd ~/dotfiles && stow -D bash
```

## Local Overrides

Machine-specific config goes in `~/.bashrc.local` (sourced at the end of `.bashrc`). This file is not tracked by git.

## Bootstrap Packages

`bootstrap.sh` installs these tools via apt (Linux) or Homebrew (macOS):

git, vim, tmux, curl, wget, htop, tree, jq, stow, unzip, zip, make, ripgrep, fzf, bat, uv, ruff, silversearcher-ag, build-essential, openssh, bash-completion, and more.
