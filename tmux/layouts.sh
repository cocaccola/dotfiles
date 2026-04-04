#!/usr/bin/env bash
# This script is used to load a tmux layout into the current session
# Tmux layouts are scripts that execute tmux commands to create a series of windows
# The first argument, if provided as "tns" indicates that this is being run from a call to "tns" which creates a new session

# tlayout - tmux layout
layout_dir=~/.tmux-layouts/

if [[ ! -d "$layout_dir" ]]; then
    echo "$layout_dir does not exist" >&2
    exit 1
fi

layout=$(find $layout_dir -type f -name '*.sh' \
    | awk -F'/' 'BEGIN { print "default" } { sub(/\.sh$/, ""); print $NF }' \
    | gum filter --limit=1 --indicator=">")

if [[ -z "$layout" ]]; then
    echo "no layout selected" >&2
    exit 1
fi

if [[ "$layout" == "default" ]]; then
    # there's nothing left to do
    exit 0
fi

/$layout_dir/${layout}.sh

# We need to handle the original window for the new session
tmux select-window -t :2

# If we run this script directly from an existing session then we want to kill the first window.
# Otherwise, when running from "tns" this script will exit and kill the first window.
if [[ "$1" != "tns" ]]; then
    tmux kill-window -t :1
fi
