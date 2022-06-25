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
if [[ -a /opt/homebrew/opt/kube-ps1/share/kube-ps1.sh ]]; then
    source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
    export PS1=$'\n''$(kube_ps1)'$'\n'$PS1
fi

# Aliases
alias vi='vim'
alias ls='ls -G'
alias ll='ls -Gl'
alias la='ls -Gla'
alias l.='ls -Gld .*'
alias l1='ls -1'
alias grep='grep --colour=always'
alias less='less -R'
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gb='git branch'
alias gco='git checkout'
alias gc='git commit'
alias gd='git diff'
alias gp='git push'
alias gpo='git push -u origin $(git branch --show-current)'
alias gsha='git rev-parse --verify HEAD'
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

# Functions
function gmp () {
    # gmp - Git checkout Main/Master & Pull
    {git co main  || git co master} &> /dev/null
    git pull
    echo -e "\nHEAD: $(git rev-parse --verify HEAD | sed s/\n//g)"
}

function gub () {
    # gub - Git Update current Branch
    local current=$(git branch --show-current)
    gmp
    git co $current

    #determine main branch
    if git rev-parse --abbrev-ref master &> /dev/null; then
        local m="master"
    else
        local m="main"
    fi

    git merge $m
}

function grm () {
    # grm - Git Rebase current branch from Main/Master
    local current=$(git branch --show-current)
    gmp

    #determine main branch
    if git rev-parse --abbrev-ref master &> /dev/null; then
        local m="master"
    else
        local m="main"
    fi

    git rebase $m $current
}

function gcob () {
    git co -b caccola/$1
}

function gdf () {
    git diff --name-status ${1}..${2}
}

function gdfm () {
    if git rev-parse --abbrev-ref master &> /dev/null; then
        local m="master"
    else
        local m="main"
    fi

    git diff --name-status $m
}

# add fuctions to add a directory to vsocde, pushd the current directory, and switch to the added directory
# add fucntions to popd back
# add function to grab current directory, popd back, and pushd the saved directory in step 1
