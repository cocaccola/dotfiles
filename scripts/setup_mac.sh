#!/usr/bin/env bash

if ! command -v brew >&-; then
    echo "please setup homebrew first" >&2
    exit 1
fi

# required packages
brew update \
    && brew install \
        bat \
        eza \
        fd \
        fzf \
        tree \
        zoxide \
        pinentry-mac \
        gnupg \
        starship

# k8s
brew install \
    kube-ps1 \
    kubectx \
    kubernetes-cli \
    k9s \
    stern

# tools
brew install \
    neovim \
    jq \
    yq \
    terraform \
    terragrunt \
    the_silver_searcher \
    ipcalc \
    git-delta \
    gum \
    cowsay \
    gh \
    lolcat \
    zellij \
    neofetch

# vscode & neovim deps
brew install ripgrep

# fonts
brew tap homebrew/cask-fonts
brew install font-fira-code-nerd-font

# make dev directory for git repos
mkdir ~/dev
