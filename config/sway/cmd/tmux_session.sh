#! /usr/bin/env bash

function tmux_sessions()
{
    tmux list-session -F '#S'
}

TMUX_SESSION=$( (echo new; tmux_sessions) | rofi -dmenu -p "TMUX sessions")
TERM=kitty

if [[ x"new" = x"${TMUX_SESSION}" ]]; then
    $TERM -e tmux new-session &
elif [[ -z "${TMUX_SESSION}" ]]; then
    echo "Cancel"
else
    $TERM -e tmux attach -t "${TMUX_SESSION}" &
fi
