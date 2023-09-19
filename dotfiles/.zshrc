# we will no longer check the below to save cpu cycles, we will leave this as a note
# dependencies
# we will check these after homebrew's path is setup
# for pbcopy you will need something that replicates its functionality on non macOS systems
# see the following for ideas:
# https://www.techtronic.us/pbcopy-pbpaste-for-wsl/
# https://lloydrochester.com/post/unix/wsl-pbcopy-pbpaste/
# https://garywoodfine.com/use-pbcopy-on-ubuntu/
#
## dependencies=(bat fd tree pbcopy gum)

# psvar indexes
# 1 - exit status
# 2 - vcs_info_wrapper
# 3 - logo

# General Behaviors
setopt autocd
setopt globdots

# History
export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export SAVEHIST=1000000000
setopt extendedhistory
setopt incappendhistorytime
setopt histfindnodups
setopt histignorealldups
setopt histexpiredupsfirst
setopt histignoredups
setopt histreduceblanks
# do not enable these
# see: https://zsh.sourceforge.io/Doc/Release/Options.html#History
# setopt sharehistory
# setopt incappendhistory
setopt histignorespace
setopt histverify
setopt histsavenodups

# fc docs
# https://zsh.sourceforge.io/Doc/Release/Shell-Builtin-Commands.html
alias history='fc -li -100 -1'
alias h='history'

# neovim as man pager
export MANPAGER='nvim +Man!'

## Base Prompts
#function get_exit_status () {
#    # https://tldp.org/LDP/abs/html/exitcodes.html
#    # 128 + signal number = signal
#    local exit_status=$?
#    if (( exit_status > 128 )); then
#       psvar[1]=$(kill -l $exit_status)
#    else
#       psvar[1]=$exit_status
#    fi
#}
#precmd_functions+=(get_exit_status)

## just for fun, display fun logos
#function logo () {
#    if [[ $(uname) == "Darwin" ]]; then
#        psvar[3]=
#    elif [[ $(uname) == "Linux" ]]; then
#        psvar[3]=󰌽
#    else
#        psvar[3]=󰮯
#    fi
#}
#precmd_functions+=(logo)

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

if [[ -d $HOME/.pyenv/bin ]]; then
    export PATH=$PATH:$HOME/.pyenv/bin
fi

# GKE

# The next line updates PATH for the Google Cloud SDK.
if [[ -f $HOME/google-cloud-sdk/path.zsh.inc ]]; then
    source $HOME/google-cloud-sdk/path.zsh.inc
fi

# The next line enables shell command completion for gcloud.
if [[ -f $HOME/google-cloud-sdk/completion.zsh.inc ]]; then
    source $HOME/google-cloud-sdk/completion.zsh.inc
fi

# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
export USE_GKE_GCLOUD_AUTH_PLUGIN=True


# Enable Ctrl-x-e to edit command line
bindkey -e
export EDITOR=nvim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Directory Stacks
# https://zsh.sourceforge.io/Intro/intro_6.html
# https://thevaluable.dev/zsh-install-configure-mouseless/
export DIRSTACKSIZE=10
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd -${index}"; unset index

# homebrew on macOS arm64
if [[ $(uname) == "Darwin" ]] && [[ $(uname -m) == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
# homebrew on Linux x86_64
elif [[ $(uname) == "Linux" ]] && [[ $(uname -m) == "x86_64" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export HOMEBREW_NO_ANALYTICS=1

# Glamor theme
# https://github.com/charmbracelet/glamour#styles
export GLAMOUR_STYLE=~/.config/glamour/catppuccin/macchiato.json

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
  export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# export PROMPT='%3v %F{49}%~ %F{253}%#%f '

# check dependencies now that homebrew's path is loaded
# disabling this for now
#for dep in ${dependencies[@]}; do
#    if ! command -v $dep >&-; then
#        echo ".zshrc requires $dep to be installed" >&2
#    fi
#done


zmodload zsh/complist
autoload -Uz compinit promptinit
compinit
promptinit

# enable auto rehash
# this may have a performance penalty
# disable if slow
zstyle ':completion:*' rehash true

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

## git info in prompt
#autoload -Uz vcs_info
#
## vcs_info wrapper to fix space padding when not in a git repo and vcs_info_msg_0_ is empty
#function vcs_info_wrapper () {
#    vcs_info
#    if [[ -z "$vcs_info_msg_0_" ]]; then
#        psvar[2]=""
#    else
#        psvar[2]="yes"
#    fi
#}
#
#precmd_functions+=(vcs_info_wrapper)
#zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:*' unstagedstr '*'
#zstyle ':vcs_info:*' stagedstr '+'
#zstyle ':vcs_info:git:*' formats       'λ %{%F{49}%}%b%{%f%}%{%F{red}%}%u%c%{%f%}'
#zstyle ':vcs_info:git:*' actionformats 'λ %{%F{49}%}%b%{%f%}|%{%F{red}%}%a%u%c%{%f%}'
#
#setopt prompt_subst

# put everything together with kube-ps1
# could reduce this using brew --prefix
#       󰀱 󰚑 󰂹 󰅏 󰆚 󰼁 󰚌 󰈸   󱓞 󱓟  
# original: ✘ ✔

## custom kube-ps1 icons don't work, likely something wrong upstream
#export KUBE_PS1_PREFIX=""
#export KUBE_PS1_SUFFIX=""
#export KUBE_PS1_SYMBOL_ENABLE="false"
#
#if [[ -a $(brew --prefix)/opt/kube-ps1/share/kube-ps1.sh ]]; then
#    source "$(brew --prefix)/opt/kube-ps1/share/kube-ps1.sh"
#    export PROMPT=$'\n''󰀱 $(kube_ps1)%(2V. ${vcs_info_msg_0_}.) %(?.%F{49}󱓞.%F{red} %v)%f'$'\n'$PS1
#else
#   export PROMPT='%(?.%F{49}󱓞.%F{red} %v)%f%(2V. ${vcs_info_msg_0_}.) '$PS1
#fi


# Commands Color Support
# This was lifted from Ubuntu on wsl2 and modified
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Setup OS specific aliases
if [[ $(uname) == "Linux" ]]; then
    alias ls='ls -F --color=auto'
    alias ll='ls -l'
    alias la='ls -la'
    alias l.='ls -ld .*'
    alias l1='ls -1'
elif [[ $(uname) == "Darwin" ]]; then
    alias ls='ls -GF'
    alias ll='ls -l'
    alias la='ls -la'
    alias l.='ls -ld .*'
    alias l1='ls -1'
#    alias grep='grep --colour=always'
else
    echo "You are not on macOS or Linux, please check .zshrc for ls color support" >&2
fi

# eza
# assumes installation of https://github.com/ryanoasis/nerd-fonts
# overwrite ls aliases if eza is installed
if command -v eza >&-; then
    alias ls='eza -F --icons'
    alias ll='ls --long --header --binary --group --links  --git'
    alias la='ls --long --header --binary --all --group  --links --git'
    alias laa='ls --long --header --binary --all --all --group  --links --git'
    alias l.='ls --long --header --binary --group --list-dirs --links --git .*'
    alias l1='ls --oneline'
    alias tree='eza --icons --tree'
fi


# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Aliases
alias wh='which'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias vi='nvim'
alias less='less -R'
alias g='git'
alias grv='git remote -v'
alias gw='git worktree'
alias gwrf='git worktree remove -f'
alias gwp='git worktree prune'
alias gwl='git worktree list'
alias gf='git fetch'
alias gfo='git fetch origin'
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gb='git branch'
alias gco='git checkout'
alias gtcln='git clone' # use gcln (below) instead
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -am'
alias gd='git diff'
alias gdc='git diff --cached'
alias gpl='git pull'
alias gsha='git rev-parse --verify HEAD'
alias gl="git log --pretty='format:%C(yellow)%h | %ad%Cred%d | %Creset%s%Cblue [%cn]' --decorate --date=iso --graph"
alias glr="git log --pretty='format:%C(yellow)%h | %ad%Cred%d | %Creset%s%Cblue [%cn]' --decorate --date=relative --reverse"
alias gst='git stash'
alias gstm='git stash -m'
alias gstl='git stash list'
alias gstp='git stash pop'
alias k='kubectl'
alias kg='kubectl get'
alias ka='kubectl apply -f'
alias kdel='kubectl delete'
alias kdelf='kubectl delete -f'
alias kd='kubectl describe'
alias kc='kubectx'
alias kn='kubens'
alias tf='terraform'
alias tg='terragrunt'
alias p='pulumi'
alias pup='pulumi up'
alias agh='ag --hidden'
alias agy='ag --yaml'
alias agtf="ag -G '.*\.(hcl|tf|tfvars)'"
alias agmd='ag --md'
alias zlj='zellij'
alias zjs='zellij -s'
alias zjls='zellij list-sessions'
alias zjk='zellij kill-session'
alias zjka='zellij kill-all-sessions'
alias zja='zellij attach'
alias zjr='zellij run'
alias zje='zellij edit'
alias ddev='cd ~/dev'
alias ghpr='gh pr create --draft --title'


# Others

# pyenv
if command -v pyenv >&- || test -d $HOME/.pyenv/bin; then
    eval "$(pyenv init -)"
fi

# keychain
if command -v keychain >&-; then
    eval $(keychain --quick --quiet --eval --noask --nogui --agents ssh)
fi

# GPG agent
# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
export GPG_TTY=$(tty)


# fzf
# install with:
# brew install fzf
# $(brew --prefix)/opt/fzf/install
# see https://github.com/junegunn/fzf#using-homebrew
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://github.com/junegunn/fzf#key-bindings-for-command-line
# CTRL-T - Paste the selected files and directories onto the command-line
# CTRL-R - Paste the selected command from history onto the command-line
# ALT-C - cd into the selected directory

# see https://betterprogramming.pub/boost-your-command-line-productivity-with-fuzzy-finder-985aa162ba5d
# Toggle preview window visibility with '?'
#--bind '?:toggle-preview'
# Select all entries with 'CTRL-A'
#--bind 'ctrl-a:select-all'
# Copy the selected entries to the clipboard with 'CTRL-Y'
#--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
# Open the selected entries in vim with 'CTRL-E'
#--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
#Open the selected entries in vscode with 'CTRL-V'
#--bind 'ctrl-v:execute(code {+})'

# Macchiato theme
# https://github.com/catppuccin/fzf
#
# original theme, edited for transparency below
#--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796
#--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
#--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796

# bat themeing
# see https://github.com/catppuccin/bat#adding-the-themes

export BAT_THEME="Catppuccin-macchiato"

if command -v eza >&-; then
    export FZF_DEFAULT_OPTS="
-m
--height 80%
--layout=reverse
--preview-window=right,70%:hidden
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (eza --icons --tree --color=always {} | less)) || echo {} 2> /dev/null | head -200'
--prompt='🔎 '
--pointer='▶'
--marker='⚑'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-v:execute(code {+})'
--bind 'alt-up:preview-page-up'
--bind 'alt-down:preview-page-down'
--color=bg+:#363a4f,bg:-1,gutter:-1,spinner:#f4dbd6,hl:#ed8796
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796
"
else
    export FZF_DEFAULT_OPTS="
-m
--height 80%
--layout=reverse
--preview-window=right,70%:hidden
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--prompt='🔎 '
--pointer='▶'
--marker='⚑'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-v:execute(code {+})'
--bind 'alt-up:preview-page-up'
--bind 'alt-down:preview-page-down'
--color=bg+:#363a4f,bg:-1,gutter:-1,spinner:#f4dbd6,hl:#ed8796
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796
"
fi

# default is **
export FZF_COMPLETION_TRIGGER="'"

# https://github.com/junegunn/fzf#settings
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
function _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
function _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

function _fzf_comprun() {
    local command=$1
    shift

    if command -v eza >&-; then
        case "$command" in
            cd)           fzf "$@" --preview 'eza --icons --tree --color=always {} | head -200' ;;
            code|open)    fzf "$@" --preview 'bat --style=numbers --color=always --line-range :500 {}' ;;
            export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
            ssh)          fzf --preview 'dig {}'                   "$@" ;;
            *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
        esac
    else
        case "$command" in
            cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
            code|open)    fzf "$@" --preview 'bat --style=numbers --color=always --line-range :500 {}' ;;
            export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
            ssh)          fzf --preview 'dig {}'                   "$@" ;;
            *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
        esac
    fi
}

# Helper Functions
function _primary_branch () {
    # _primary_branch fetches the primary branch name
    local __primary_branch_ret_val=$1

    #determine main branch
    if git rev-parse --abbrev-ref master &> /dev/null; then
        eval $__primary_branch_ret_val="master"
    else
        eval $__primary_branch_ret_val="main"
    fi
}

function _change_to_bare () {
    if [ ! -d .bare ]; then
        cd $(git worktree list | awk '/\(bare\)/ { sub(/\.bare/, "", $1); print $1}')
    fi
}

# Functions
function zj () {
    local current_dir=$(pwd)
    cd
    zellij attach --create the-one-session-to-rule-them-all
    cd $current_dir
}

function v () {
    if [ -z "$1" ]; then
        nvim .
        return
    fi

    local current_dir=$(pwd)

    if [ -d "$1" ]; then
        cd $1
        nvim .
        cd $current_dir
        return
    fi

    cd $(dirname $1)
    nvim $(basename $1)
    cd $current_dir
}

function dev () {
    # change between repos in ~/dev

    local selected
    selected=$(\
        fd -t d -d 1 -H -x echo {/} \; . ~/dev \
        | gum filter --limit=1 --indicator=">")

    cd ~/dev/$selected
}

function nvmld () {
    # nvmld - load nvm

    # nvm / node.js
    [[ -d "$HOME/.nvm" ]] || mkdir $HOME/.nvm
    export NVM_DIR="$HOME/.nvm"

    # This loads nvm
    [[ -s "$(brew --prefix nvm)/nvm.sh" ]] && source $(brew --prefix nvm)/nvm.sh

    # This loads nvm bash_completion
    [[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ]] && source $(brew --prefix nvm)/etc/bash_completion.d/nvm
}

function nvm () {
    # this function is a wrapper for nvm that lazy loads nvm
    # loading nvm is slow

    if [ -z "$NVM_DIR" ]; then
        nvmld

        nvm "$@"
        return
    fi
    nvm "$@"
}

function clean_branches () {
    # clean_branches - cleans up local branches

    local current=$(git branch --show-current)

    local branch_name
    _primary_branch branch_name
    git stash -m 'stashed from clean_branches'

    git checkout $branch_name
    git fetch --prune

    # might need git branch -D
    git branch -vv | awk '/: gone]/ { if ($1 !~ /(\*|main|master)/) system("git branch -d "$1) }'
    git checkout $current
    git stash pop
}

function add_reviewers () {
    # add_reviewers - add reviewers to a pr
    # the default reviewers should be sourced from a user supplied zshrc snippet
    # if [ -z "$DEFAULT_REVIEWERS" ]; then
    #     echo "default reviewers is missing" >&2
    #     return
    # fi
    # selection=$(\
    #     gum choose \
    #         --limit=1 \
    #         --selected="default" \
    #         "default" "custom")

    # if [[ $selection == "default" ]]; then

    #     return
    # fi
    echo "to do"
}

function gcln () {
    # gcln - clone a bare repo and setup main branch with git worktrees
    # based on ideas from https://morgan.cugerone.com/blog/workarounds-to-git-worktree-using-bare-repository-and-cannot-fetch-remote-branches/

    local repo_dir=${${1##*/}%.git}

    mkdir $repo_dir
    cd $repo_dir

    git clone --bare $1 .bare
    echo "gitdir: ./.bare" > .git

    # set the remote origin fetch so we can fetch remote branches
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

    # get all branches from origin
    # use git fetch origin to update the bare repo
    git fetch origin

    local branch_name
    _primary_branch branch_name

    git worktree add $branch_name
    git branch --set-upstream-to=origin/$branch_name $branch_name

    cd ..
}

function gwco () {
    # gwco - checkout branch using worktrees
    local branch

    _change_to_bare

    if [ -n "$1" ]; then
        git worktree add $1
        cd $1
        return
    fi
    branch=$(git branch \
        | gum filter --limit=1 --indicator=">" \
        | awk '{ if($1 ~ /[+*]/) { print $2 } else { print $1 } }')

    if [ -z "$branch" ]; then
        echo "nothing selected" >&2
        return
    fi

    if [ -d $branch ]; then
        echo "branch is already checked out" >&2
        return
    fi

    git worktree add $branch
    git branch --set-upstream-to=origin/$branch $branch
    cd $branch
}

function gwr () {
    # gwr - git worktree remove
    local worktrees
    local selected

    _change_to_bare

    if [ -n "$1" ]; then
        git worktree remove $1
        return
    fi

    worktrees=$(git worktree list \
        | awk '/\[.*\]/ { if ($NF !~ /main|master|bare/) { gsub(/[\[\]]/, "", $NF); print $NF } }')

    if [ -z "$worktrees" ]; then
        echo "no worktrees to remove" >&2
        return
    fi

    selected=$(echo $worktrees | gum filter --limit=1 --indicator=">")

    if [ -z "$selected" ]; then
        echo "nothing selected" >&2
        return
    fi

    # fetch path of selected worktree
    wt_path=$(\
        git worktree list \
            | awk -v selected=$selected '$NF ~ selected { print $1; exit }')

    if [ ! -d $wt_path ]; then
        # this shouldn't happen
        echo "the directory does not exist" >&2
        return
    fi

    git worktree remove $wt_path
}

function gwcob () {
    # gwcob - Git CheckOut Branch (worktrees)
    _change_to_bare

    local __branch_suffix="unnamed-$RANDOM"
    if [ -n "$1" ]; then
        __branch_suffix=$1
    fi

    git worktree add -b caccola/$__branch_suffix $__branch_suffix
    cd $__branch_suffix
}

function gws () {
    # gws - git worktree switch
    local selected

    selected=$(git worktree list \
        | awk '{ if ($NF !~ /\(bare\)/) print $0 }' \
        | gum filter --limit=1 --indicator=">" \
        | awk '{print $1}')

    if [ -z "$selected" ]; then
        echo "nothing selected" >&2
        return
    fi

    cd $selected

    if [[ "$TERM_PROGRAM" == "vscode" ]]; then
        code -a $selected
    fi
}

function gwfo () {
    # gwfo - git worktree fetch origin
    # update worktree branches
    local current_dir=$(pwd)

    _change_to_bare
    git fetch origin

    cd $current_dir
}

function gmp () {
    # gmp - Git checkout Main/Master & Pull

    # if there are any changes git checkout will fail
    git diff HEAD --quiet --exit-code
    if [ $? -ne 0 ]; then
        echo "!!!! Stashing Changes !!!!"
        git stash -m 'stashed from gmp'
    fi

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
    git stash -m 'stashed from gub'
    gmp
    git checkout $current

    local branch_name
    _primary_branch branch_name

    git merge $branch_name
    git stash pop
}

function grm () {
    # grm - Git Rebase current branch from Main/Master
    local current=$(git branch --show-current)
    gmp

    local branch_name
    _primary_branch branch_name

    git rebase $branch_name $current
}

function gcob () {
    # gcob - Git CheckOut Branch
    local __branch_suffix="unnamed-$RANDOM"
    if [ -n "$1" ]; then
        __branch_suffix=$1
    fi

    git checkout -b caccola/$__branch_suffix
}

function gdf () {
    # gdf - Git Diff Files between commits
    # example:
    #   % gdf 1bae4c1 3e7cf49
    #   A       Makefile
    #   M       dotfiles/.zshrc
    git diff --name-status ${1}..${2}
}

function gdfm () {
    # gdfm - Git Diff Files against Main/Master
    local branch_name
    _primary_branch branch_name

    git diff --name-status $branch_name
}

function gla () {
    # gla - Git Log by Author
    gl --author=$1
}

function glar () {
    # glar - Git Log by Author (reverse)
    glr --author=$1
}

function gacp () {
    # gacp - git add / commit / push
    if [ -z "$1" ]; then
        echo "commit message needed"
        return
    fi
    git add -A
    git commit -am "$1"
    gp
}

function gacpr () {
    # gacpr - git add / commit / push / create pr
    if [ -z "$1" ]; then
        echo "commit message needed"
        return
    fi
    gacp "$1"
    gh pr create --draft --title "$1"
}

function rdy () {
    # rdy - mark a pr as ready
    # for now we are going to be super lazy and just use a single set of reviwers
    if [ -z "$DEFAULT_REVIEWERS" ]; then
        echo "DEFAULT_REVIEWERS is not set in the env" >&2
        return
    fi

    gh pr ready

    gh pr edit --add-reviewer $DEFAULT_REVIEWERS
}

function gham () {
    # gham - github auto merge
    # enables auto merge on a pr
    gh pr merge --auto --squash
}

function ghdam () {
    # ghdam - github disable auto merge
    # disables auto merge on a pr
    gh pr merge --disable-auto
}

function woof () {
    # woof - wonderful one off
    if [ -z "$1" ]; then
        echo "commit message needed"
        return
    fi
    gacpr "$1"
    rdy
    gham
}

function kpn () {
    # kpn - Kubernetes Pods on Node
    kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=$1
}

function asn () {
    # asn - asn lookup
    whois -h whois.cymru.com " -v $1"
}

function moo () {
    cowsay Moooooooooo | lolcat
}

#### User supplied zshrc config ####
export ZSHRC_USER_CONFIG_DIR="$HOME/.zsh/user/"
if [ -d ~/.zsh/user ]; then
    # https://zsh.sourceforge.io/Doc/Release/Expansion.html#Glob-Qualifiers
    for config in ~/.zsh/user/*(.N); do
        source $config
    done
else
    echo "The user config dir (~/.zsh/user) is missing." >&2
fi

#### plugins ####
source ~/.zsh/catppuccin/catppuccin_macchiato-zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zoxide - I don't use this
# eval "$(zoxide init zsh)"

# direnv
# run silently
# see https://github.com/direnv/direnv/blob/master/internal/cmd/log.go#L36-L44
export DIRENV_LOG_FORMAT=""
eval "$(direnv hook zsh)"

# need to remove other stuff from PS1 above
eval "$(starship init zsh)"

# motd
moo
