#export PS1='%F{39}%n %F{49}%~ %F{253}%#%f '
export PS1='%F{49}%~ %F{253}%#%f '

if [[ -d $HOME/go/bin ]]; then
    export PATH=$PATH:$HOME/go/bin
fi

if [[ -d $HOME/bin ]]; then
    export PATH=$PATH:$HOME/bin
fi

if [[ -d /usr/local/go/bin ]]; then
    export PATH=$PATH:/usr/local/go/bin
fi

if [[ -a /usr/local/opt/gnu-sed/libexec/gnubin ]]; then
    export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
fi

if [[ -a /usr/local/opt/make/libexec/gnubin ]]; then
    export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
fi


# Enable Ctrl-x-e to edit command line
EDITOR=vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# need to read more about these
autoload -Uz compinit promptinit
compinit
promptinit

#not sure if I like this one
#setopt correctall

# kube-ps1
if [[ -a /usr/local/opt/kube-ps1/share/kube-ps1.sh ]]; then
    source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
    PS1='$(kube_ps1) '$PS1
fi

# Aliases
alias vi='vim'
alias ls='ls -G'
alias ll='ls -Gl'
alias la='ls -Gla'
alias l.='ls -Gld .*'
alias grep='grep --colour=always'
alias less='less -R'
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gc='git commit '
alias gd='git diff'
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kc='kubectx'
alias kn='kubens'

if [[ -d $HOME/.pyenv/bin ]]; then
    export PATH=$PATH:$HOME/.pyenv/bin
fi

# pyenv
if command -v pyenv >&- || test -d $HOME/.pyenv/bin; then
    eval "$(pyenv init -)"
fi

# keychain
if command -v keychain >&-; then
    eval $(keychain --quick --quiet --eval --noask --nogui --agents ssh)
fi
