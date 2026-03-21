# ~/.bash_profile: executed by bash(1) for login shells.
# On macOS, Terminal.app runs login shells by default, so this is the entrypoint.

# Source .bashrc for consistent behavior across login and non-login shells
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi
