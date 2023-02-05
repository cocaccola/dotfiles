#!/usr/bin/env bash

usage () {
    echo "please use either -k or -s"
}

start_tmux () {
    declare -A windows
    index=2

    while read line; do
        if [[ "$line" =~ ^# ]]; then
            continue
        fi
        windows[$index]="$line"
        ((index++))
    done < ~/.tmux_windows

    tmux new-session -d -s 'main' -n 'local'
    for window in "${!windows[@]}"; do
        window_name="$(echo ${windows[$window]} | cut -d, -f1)"
        window_cmd="$(echo ${windows[$window]} | cut -d, -f2)"
        tmux new-window -t "main:$window" -n "$window_name" "$window_cmd"
    done

    tmux select-window -t "main:1"
    tmux attach-session -t "main"
}

stop_tmux () {
    tmux kill-session -t "main"
}

case $1 in
    -s) start_tmux ;;
    -k) stop_tmux ;;
    *) usage ;;
esac
