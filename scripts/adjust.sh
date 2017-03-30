#!/usr/bin/env bash
adjust() {
    local _CMD='stty rows #{pane_height} cols #{pane_width} && clear'
    local _IS_SYNC="$(tmux list-windows -F '#{window_id} #{window_active} #{pane_synchronized}' | awk '$2 == 1 && $3 == 1' | grep -c .)"

    if [[ "$_IS_SYNC" == "1" ]];then
        tmux set-window-option synchronize-panes off
    fi

    tmux list-panes -F "tmux send-keys -t #{pane_id} '${_CMD}' C-m" | sh

    if [[ "$_IS_SYNC" == "1" ]];then
        tmux set-window-option synchronize-panes on
    fi
}

adjust
