#!/usr/bin/env bash
# This script is used to load a tmux layout into the current session
# Tmux layouts are scripts that execute tmux commands to create a series of windows

LAYOUT_DIR=~/.tmux-layouts/

if [[ ! -d "$LAYOUT_DIR" ]]; then
    echo "$LAYOUT_DIR does not exist" >&2
    exit 1
fi

layout=$(find $LAYOUT_DIR -type f -name '*.sh' \
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

/$LAYOUT_DIR/${layout}.sh

# We need to handle the original window for the new session
tmux select-window -t :2
tmux kill-window -t :1
