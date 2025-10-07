#!/usr/bin/env bash

# Auto-start tmux
# init_session() {
#     if command -v tmux &> /dev/null; then
#         if [ -z "$TMUX" ]; then
#             tmux attach -t Main || tmux new -s Main
#             exit 0
#         else
#             read -rp "Enter new session name: " SESSION_NAME
#             if [[ -z "$TMUX" ]]; then
#                 tmux attach -t Main || tmux new -s Main
#                 exit 0
#             else
#                 SESSION_NAME=""
#                 if [[ -z "$SESSION_NAME" ]]; then
#                     read -rp "Enter new session name: " SESSION_NAME || exit 1
#                 fi
#             fi
#             [ -z "$SESSION_NAME" ] && echo "Session name cannot be empty!" && exit 1
#
#             START_DIR="${PWD}"
#
#             tmux new-session -d -s "$SESSION_NAME" -c "$START_DIR"
#             tmux switch-client -t "$SESSION_NAME"
#             exit 0
#         fi
#     fi
# }

init_session() {
    if ! command -v tmux &> /dev/null; then
        echo "TMUX not found!"
        exit 1
    fi

    if [ -z "$TMUX" ]; then
        tmux attach -t Main || tmux new -s Main
    else
        read -rp "Enter new session name: " SESSION_NAME
        [ -z "$SESSION_NAME" ] && echo "Session name cannot be empty!" && exit 1

        START_DIR="${PWD}"
        tmux new-session -d -s "$SESSION_NAME" -c "$START_DIR"
        tmux switch-client -t "$SESSION_NAME"
    fi
}


switch_session() {
    local SESSIONS
    SESSIONS=$(tmux ls 2>/dev/null || true)
    if [[ -z "$SESSIONS" ]]; then
        echo "No tmux sessions found."
        exit 1
    fi
    SWITCH_SESSSION_NAME=$(tmux ls 2>/dev/null | sk --prompt="Select Session to Switch to > " | cut -d':' -f1) || exit 0
    if [ -z "$TMUX" ]; then
        # Not inside tmux → attach
        tmux attach-session -t "$SWITCH_SESSSION_NAME"
    else
        # Already inside tmux → switch-client
        if [[ "$CURRENT_SESSION" != "$SWITCH_SESSSION_NAME" ]]; then
            tmux switch-client -t "$SWITCH_SESSSION_NAME"
        else
            echo "Cannot Switch to the Current Session"
            exit 1
        fi
        CURRENT_SESSION=$(tmux display-message -p '#S')
    fi
}

delete_session() {
    local KILL_SESSION_NAME
    KILL_SESSION_NAME=$(tmux ls 2>/dev/null | sk --prompt="Select Session to Kill > " | cut -d':' -f1) || exit 0

    if [[ -z "$KILL_SESSION_NAME" ]]; then
        echo "No session selected."
        exit 1
    fi


    if [ -z "$TMUX" ]; then
        # Not inside tmux → attach
        tmux kill-session -t "$KILL_SESSION_NAME"
    else
        # Already inside tmux → switch-client

        # Check whether deleting the current session
        CURRENT_SESSION=$(tmux display-message -p '#S')
        # while [ "${CURRENT_SESSION}" == "${KILL_SESSSION_NAME}" ]; do
        #     echo "Please Switch to another Session first..."
        #     switch_session
        #     CURRENT_SESSION=$(tmux display-message -p '#S')
        # done
        count=0
        while [ "${CURRENT_SESSION}" == "${KILL_SESSION_NAME}" ] && [ $count -lt 3 ]; do
            echo "Switch to another session..."
            switch_session
            CURRENT_SESSION=$(tmux display-message -p '#S')
            ((count++))
        done
        tmux kill-session -t "$KILL_SESSION_NAME"
        echo "Killed $KILL_SESSION_NAME"
    fi
}

if [ -n "$TMUX" ]; then
    # tmux new-window -n TMXS
    if [[ $# == 0 ]]; then
        # echo "Failed to initialize session, you already have one..."
        # exit 1
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
    tmux kill-window -t TMXS 2>/dev/null
else
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
fi
