# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ---------- History ----------
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000

# ---------- Shell Options ----------
shopt -s checkwinsize
shopt -s globstar 2>/dev/null
shopt -s nocaseglob 2>/dev/null
shopt -s cdspell 2>/dev/null

# ---------- Prompt ----------
# Use starship if available, otherwise fallback to a basic prompt
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
else
    if [[ "$(uname)" == "Darwin" ]]; then
        _os_color="33"  # yellow for mac
    else
        _os_color="32"  # green for linux
    fi
    PS1='\[\033[01;${_os_color}m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;\u@\h: \w\a\]$PS1"
        ;;
    esac
fi

# ---------- Colors ----------
export COLORTERM=truecolor
export CLICOLOR=1

# Linux color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# macOS color support
if [[ "$(uname)" == "Darwin" ]]; then
    export LSCOLORS=GxFxCxDxBxegedabagaced
    alias ls='ls -G'
fi

# ---------- Lesspipe ----------
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ---------- PATH ----------
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"

# Homebrew (macOS)
if [[ "$(uname)" == "Darwin" ]]; then
    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

# ---------- Editor ----------
export EDITOR=vim
export VISUAL=vim

# ---------- Aliases ----------
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ---------- Completion ----------
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
    # Homebrew completions (macOS)
    if type brew &>/dev/null; then
        BREW_PREFIX="$(brew --prefix)"
        if [[ -r "${BREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
            . "${BREW_PREFIX}/etc/profile.d/bash_completion.sh"
        fi
    fi
fi

# ---------- Local overrides ----------
# Source machine-specific config that shouldn't be in version control
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
