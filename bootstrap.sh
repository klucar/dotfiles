#!/usr/bin/env bash
#
# bootstrap.sh - Install packages for a fresh machine (Linux or macOS)
#
set -euo pipefail

# ---------- Detect OS ----------
OS="$(uname -s)"
echo "Detected OS: $OS"

# ---------- Package lists ----------
# Core tools to install on any system
COMMON_PACKAGES=(
    git
    vim
    tmux
    curl
    wget
    htop
    tree
    jq
    stow
    unzip
    zip
    make
    ripgrep
    fzf
    bat
    gh
)

LINUX_PACKAGES=(
    silversearcher-ag
    build-essential
    openssh-server
    ca-certificates
    gnupg
    software-properties-common
    bash-completion
    xclip
    net-tools
)

MACOS_PACKAGES=(
    bash
    the_silver_searcher
    openssh
    gnu-sed
    coreutils
    bash-completion@2
    watch
    starship
)

# ---------- Install functions ----------
install_linux() {
    echo ""
    echo "==> Updating apt package index..."
    sudo apt-get update -qq

    echo ""
    echo "==> Installing packages..."
    sudo apt-get install -y "${COMMON_PACKAGES[@]}" "${LINUX_PACKAGES[@]}"

    # Install starship prompt
    if ! command -v starship &>/dev/null; then
        echo ""
        echo "==> Installing Starship prompt..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi

    # Install 1Password CLI
    if ! command -v op &>/dev/null; then
        echo ""
        echo "==> Installing 1Password CLI..."
        curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
            sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
            sudo tee /etc/apt/sources.list.d/1password.list
        sudo apt-get update -qq
        sudo apt-get install -y 1password-cli
    fi

    echo ""
    echo "==> Linux packages installed successfully."
}

install_macos() {
    # Install Homebrew if not present
    if ! command -v brew &>/dev/null; then
        echo ""
        echo "==> Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add brew to PATH for this session
        if [[ -x /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -x /usr/local/bin/brew ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi

    echo ""
    echo "==> Updating Homebrew..."
    brew update

    echo ""
    echo "==> Installing packages..."
    brew install "${COMMON_PACKAGES[@]}" "${MACOS_PACKAGES[@]}"

    # Set Homebrew bash as default shell
    BREW_BASH="$(brew --prefix)/bin/bash"
    if [[ -x "$BREW_BASH" ]]; then
        if ! grep -qF "$BREW_BASH" /etc/shells; then
            echo ""
            echo "==> Adding Homebrew bash to /etc/shells..."
            echo "$BREW_BASH" | sudo tee -a /etc/shells >/dev/null
        fi
        if [[ "$SHELL" != "$BREW_BASH" ]]; then
            echo ""
            echo "==> Setting Homebrew bash as default shell..."
            chsh -s "$BREW_BASH"
        fi
    fi

    # Install 1Password CLI (cask)
    if ! command -v op &>/dev/null; then
        echo ""
        echo "==> Installing 1Password CLI..."
        brew install --cask 1password-cli
    fi

    echo ""
    echo "==> macOS packages installed successfully."
}

# ---------- Main ----------
echo "========================================"
echo "  Dotfiles Bootstrap"
echo "========================================"

case "$OS" in
    Linux)
        install_linux
        ;;
    Darwin)
        install_macos
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
esac

echo ""
echo "==> Bootstrap complete!"
echo ""
echo "Next steps:"
echo "  cd ~/dotfiles && ./install.sh"
