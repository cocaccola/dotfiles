#!/usr/bin/env bash

if ! command -v brew >&-; then
    echo "please setup homebrew first" >&2
    exit 1
fi

# required packages
brew update && brew install bat exa fd fzf tree

# k8s
brew install kube-ps1 kubectx kubernetes-cli k9s stern

# tools
brew install neovim jq yq terraform terragrunt the_silver_searcher ipcalc

# fonts
brew tap homebrew/cask-fonts
brew install font-fira-code-nerd-font