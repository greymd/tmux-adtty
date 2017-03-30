#!/usr/bin/env bash

_ADTTY_CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
_ADTTY_EXECUTION="bash $_ADTTY_CURRENT_DIR/scripts/adjust.sh"

default_adjust_key="a"
adjust_option="@adtty"

# Came from helper.sh
# link: https://github.com/tmux-plugins/tmux-yank/blob/master/scripts/helpers.sh
get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local option_value=$(tmux show-option -gqv "$option")
    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

main() {
    local key_bindings=$(get_tmux_option "$adjust_option" "$default_adjust_key")
    for key in $key_bindings; do
        tmux bind-key "$key_bindings" run-shell "$_ADTTY_EXECUTION"
    done

}

main
