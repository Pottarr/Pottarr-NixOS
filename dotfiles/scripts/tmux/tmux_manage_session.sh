#!/usr/bin/env bash

# pick_dir() {
#     local start_dir="${1:-$PWD}"
#     local selected_dir action
#
#     while true; do
#         selected_dir=$( (echo ".."; fd . --type d --max-depth 1 "$start_dir") | fzf \
#             --prompt="Browse ($start_dir) > " \
#             --header="ENTER: open dir | CTRL-Y: select | ESC: cancel" \
#             --preview 'tree -L 1 {} | head -100' \
#             --preview-window=right:60% \
#             --bind "enter:execute-silent(echo enter > /tmp/fzf_action; echo {} > /tmp/fzf_dir)+abort" \
#             --bind "alt-enter:execute-silent(echo select > /tmp/fzf_action; echo {} > /tmp/fzf_dir)+abort")
#
#         # Cancel (ESC)
#         [[ -z "$selected_dir" ]] && echo "" && return 1
#
#         action=$(cat /tmp/fzf_action 2>/dev/null)
#         rm -f /tmp/fzf_action
#         selected_dir=$(cat /tmp/fzf_dir 2>/dev/null)
#         rm -f /tmp/fzf_dir
#
#         case "$action" in
#             enter)
#                 # Go up one dir if ".." selected
#                 if [[ "$selected_dir" == ".." ]]; then
#                     start_dir=$(dirname "$start_dir")
#                 else
#                     start_dir="$selected_dir"
#                 fi
#                 ;;
#             select)
#                 echo "$selected_dir"
#                 return 0
#                 ;;
#         esac
#     done
# }

# Auto-start tmux
init_session() {
    if command -v tmux &> /dev/null; then
        if [ -z "$TMUX" ]; then
            tmux attach -t main || tmux new -s main
        else
            read -rp "Enter new session name: " SESSION_NAME
            [ -z "$SESSION_NAME" ] && echo "Session name cannot be empty!" && exit 1

            START_DIR="${PWD}"
            # START_DIR=$(pick_dir "$PWD")
            # [ -z "$START_DIR" ] && echo "No directory selected." && exit 1

            tmux new-session -d -s "$SESSION_NAME" -c "$START_DIR"
            tmux switch-client -t "$SESSION_NAME"
        fi
    fi
}

switch_session() {
    SWITCH_SESSSION_NAME=$(tmux ls 2>/dev/null | sk --prompt="Select Session to Switch to > " | cut -d':' -f1) || exit 0
    if [ -z "$TMUX" ]; then
        # Not inside tmux → attach
        tmux attach-session -t "$SWITCH_SESSSION_NAME"
    else
        # Already inside tmux → switch-client
        if [[ "${CURRENT_SESSION}" == "${KILL_SESSSION_NAME}" ]]; then
            tmux switch-client -t "$SWITCH_SESSSION_NAME"
        else
            echo "Cannot Switch to the Current Session"
            exit 1
        fi
    fi
}

delete_session() {
    KILL_SESSSION_NAME=$(tmux ls 2>/dev/null | sk --prompt="Select Session to Kill > " | cut -d':' -f1) || exit 0
    if [ -z "$TMUX" ]; then
        # Not inside tmux → attach
        tmux kill-session -t "$KILL_SESSSION_NAME"
    else
        # Already inside tmux → switch-client

        # Check whether deleting the current session
        CURRENT_SESSION=$(tmux display-message -p '#S')
        while [ "${CURRENT_SESSION}" == "${KILL_SESSSION_NAME}" ]; do
            echo "Please Switch to another Session first..."
            switch_session
            CURRENT_SESSION=$(tmux display-message -p '#S')
        done
        tmux kill-session -t "$KILL_SESSSION_NAME"
    fi
}

if [[ $# == 0 ]]; then
    init_session
    exit 0
fi
if [[ $# != 1 ]]; then
    echo "Invalid number of arguments. We need 0 to 1, you entered " $#
else
    case $1 in
        -sw|--switch-session)
        switch_session
        ;;
        -de|--delete-session)
        delete_session
        ;;
        *)
        echo "Unknown option $1"
        exit 1
        ;;
    esac
fi

if [ -n "$TMUX" ]; then
    tmux kill-pane
fi
