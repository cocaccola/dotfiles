# TODOs
# integrate fzf
# write unified main or master helper function

# General Behaviors
setopt autocd
setopt globdots

# History
export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
setopt extendedhistory
setopt histfindnodups
setopt histignorealldups
setopt histexpiredupsfirst
setopt histignoredups
setopt incappendhistory
setopt histreduceblanks
alias history='fc -li -100 -1'

# Base Prompts
function get_exit_status () {
    # https://tldp.org/LDP/abs/html/exitcodes.html
    # 128 + signal number = signal
    if (( $1 > 128 )); then
        echo $(kill -l $1)
    else
        echo $1
    fi
}

export PROMPT='%F{49}%~ %F{253}%#%f '
# this doesn't display on the line I want
#export RPROMPT='%(?.%F{49}✔.%F{red}✘ $(get_exit_status $?))%f'

# Path addons
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

if [[ -d $HOME/.pyenv/bin ]]; then
    export PATH=$PATH:$HOME/.pyenv/bin
fi


# Enable Ctrl-x-e to edit command line
EDITOR=vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Directory Stacks
# https://zsh.sourceforge.io/Intro/intro_6.html
# https://thevaluable.dev/zsh-install-configure-mouseless/
DIRSTACKSIZE=10
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd -${index}"; unset index

# Completions
# https://thevaluable.dev/zsh-completion-guide-examples/
# Homebrew completions (must be before compinit)
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# from the docs:
# You may also need to forcibly rebuild zcompdump:
# rm -f ~/.zcompdump; compinit
# Additionally, if you receive “zsh compinit: insecure directories” warnings
# when attempting to load these completions, you may need to run this:
# chmod -R go-w "$(brew --prefix)/share"

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

zmodload zsh/complist
autoload -Uz compinit promptinit
compinit
promptinit

# I have no idea what verbose yes actually does
#zstyle ':completion:*' verbose yes
zstyle ':completion:*' file-sort modification reverse
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "~/.zcompcache"
zstyle ':completion:*' file-list all

# add completion for special dirs '.' and '..'
zstyle ':completion:*' special-dirs true

# this may be needed in the future (seems to do the correct thing in the default config)
# this makes it so where if there's a single autocompletion candidate hitting tab once will just 
# fill in the completion (like it does in bash)
# zstyle '*' single-ignored complete

# this doesn't work on macOS with BSD ls :(
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# https://zsh.sourceforge.io/Doc/Release/Completion-System.html#Standard-Styles
# other values to try in place of 'search' are 'interactive' and 'search-backward'
# vi keybindings for menuselect do not play nicely with search/search-backward/interactive

# I really don't like this feature
#zstyle ':completion:*' menu select interactive


zstyle ':completion:*' expand yes

# this is a cool idea and looks nice, however the non-grouped way of doing this works better for me
#zstyle ':completion:*:*:*:*:descriptions' format '%F{49}-- %d --%f'
#zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
#zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
#zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

#zstyle ':completion:*' group-name ''
# the ordering does not appear to working 100% correctly...
# There isn't a tag for aliases sadly
# https://zsh.sourceforge.io/Doc/Release/Completion-System.html#Initialization
#zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands

# vi keybindings for menuselect do not play nicely with search/search-backward/interactive
# use the default gnu readline / emacs shortcuts for this
#bindkey -M menuselect 'h' vi-backward-char
#bindkey -M menuselect 'k' vi-up-line-or-history
#bindkey -M menuselect 'j' vi-down-line-or-history
#bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect '^xi' vi-insert
bindkey -M menuselect '^x^i' vi-insert
# '/' is really annoying for autocomplete as we type / in paths all the time
#bindkey -M menuselect '/' history-incremental-search-forward
#bindkey -M menuselect '?' history-incremental-search-backward
bindkey -M menuselect '?' history-incremental-search-forward

# disable the really annoying zsh autocomplete behavior
# make it behave more like bash
setopt noautomenu
setopt nomenucomplete

setopt autoparamslash
unsetopt completealiases

#not sure if I like this one
#setopt correctall

# Prompt enhancements

# git info in prompt
autoload -Uz vcs_info
precmd () { vcs_info }
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats       'λ %{%F{49}%}%b%{%f%}%{%F{red}%}%u%c%{%f%}'
zstyle ':vcs_info:git:*' actionformats 'λ %{%F{49}%}%b%{%f%}|%{%F{red}%}%a%u%c%{%f%}'

setopt prompt_subst

# put everything together with kube-ps1
# could reduce this using brew --prefix
if [[ -a /opt/homebrew/opt/kube-ps1/share/kube-ps1.sh ]]; then
    source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
    export PROMPT=$'\n''$(kube_ps1) ${vcs_info_msg_0_} %(?.%F{49}✔.%F{red}✘ $(get_exit_status $?))%f'$'\n'$PS1
elif [[ -a /usr/local/opt/kube-ps1/share/kube-ps1.sh ]]; then
    source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
    export PROMPT=$'\n''$(kube_ps1) ${vcs_info_msg_0_} %(?.%F{49}✔.%F{red}✘ $(get_exit_status $?))%f'$'\n'$PS1
else
   export PROMPT='%(?.%F{49}✔.%F{red}✘ $(get_exit_status $?))%f ${vcs_info_msg_0_} '$PS1
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
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gb='git branch'
alias gco='git checkout'
alias gc='git commit -m'
alias gca='git commit -am'
alias gd='git diff'
alias gdc='git diff --cached'
alias gpl='git pull'
alias gsha='git rev-parse --verify HEAD'
alias gl='git l'
alias glr='git lr'
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kc='kubectx'
alias kn='kubens'
alias tf='terraform'
alias tg='terragrunt'


# Others

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

function gp () {
    # gp - Git Push
    # if there is no upstream branch we will set that up automatically
    local branch=$(git branch --show-current)
    local upstream_branch=$(git ls-remote --heads origin $branch)
    if [[ -z $upstream_branch ]]; then
        # there is no upstream branch yet
        git push -u origin $branch
    else
        # there is an upstream branch
        git push
    fi
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
    # gcob - Git CheckOut Branch
    git co -b caccola/$1
}

function gdf () {
    # gdf - Git Diff Files
    git diff --name-status ${1}..${2}
}

function gdfm () {
    # gdfm - Git Diff Files against Main/Master
    if git rev-parse --abbrev-ref master &> /dev/null; then
        local m="master"
    else
        local m="main"
    fi

    git diff --name-status $m
}

function gla () {
    # gla - Git Log by Author
    git l --author=$1
}
