# ---------- Navigation ----------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias home='cd ~'
alias code='cd ~/code'

# ---------- Listing ----------
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lrt='ls -lrt'
alias sl='ls'

# ---------- Safety ----------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ---------- Shortcuts ----------
alias h='history'
alias hgrep='history | grep'
alias more='less'
alias mroe='more'
alias cls='clear'

# ---------- Disk ----------
alias df='df -h'
alias du='du -h'

# ---------- Networking ----------
alias ports='netstat -tulanp 2>/dev/null || lsof -i -P -n'

# ---------- Git ----------
alias gs='git status'
alias gl='git log --oneline -20'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'
alias gb='git branch'
alias gco='git checkout'

# ---------- Tmux ----------
alias ta='tmux attach -t'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'

# ---------- Grep ----------
alias grep='grep --color=auto'
