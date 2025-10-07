#!/usr/bin/env bash

CONFIG="$HOME/.config/tmux/dir_list"

append_dir() {
    if [[ ! -f "$CONFIG" ]]; then
        mkdir -p "$(dirname "$CONFIG")"
        touch "$CONFIG"
    fi
    local TARGET
    if [[ $# == 0 ]]; then
        TARGET="$PWD"
    elif [[ $# == 1 ]]; then
        TARGET=$(realpath "$1")
    else
        echo "Invalid number of arguments. We need 0 to 1, you entered " $#
        exit 1
    fi
    if ! rg -q -N -U -F -x  "$TARGET" "$CONFIG"; then
        echo "$TARGET" >> "$CONFIG"
        echo "Added $TARGET to the list..."
        exit 0
    else
        echo "Directory already existed..."
        exit 1
    fi
}

delete_dir() {
    if [[ ! -f "$CONFIG" ]]; then
        echo "File does not exist: $CONFIG"
        echo "No directory to delete..."
        exit 1
    fi
    local TARGET=""
    if [[ $# == 0 ]]; then
        if [[ ! -s "$CONFIG" ]]; then
            echo "No directories to select."
            exit 1
        fi
        if [[ -n "$TARGET" ]]; then
            local ESC
            ESC=$(printf '%s\n' "$TARGET" | sed 's/[\/&]/\\&/g')
            sed -i "/$ESC/d" "$CONFIG"
            echo "Directory already existed..."
            exit 0
        else
            echo "No directory selected..."
            exit 1
        fi
    elif [[ $# == 1 ]]; then
        TARGET="$1"
        if rg -q -N -U -i "$TARGET" "$CONFIG"; then
            local ESC
            ESC=$(printf '%s\n' "$TARGET" | sed 's/[\/&]/\\&/g')
            sed -i "/$ESC/d" "$CONFIG"
            echo "Deleted ${TARGET} from the list..."
        fi
    else
        echo "Invalid number of arguments. We need 0 to 1, you entered " $#
        exit 1
    fi
}

edit_dir() {
    nvim "$CONFIG"
    exit 0
}

select_dir() {
    if [[ ! -f "$CONFIG" ]]; then
        echo "File does not exist: $CONFIG"
        echo "No directory to select..."
        exit 1
    fi
    local TARGET=""
    local EXTERNAL_TARGET="$1"
    if [[ $# == 0 ]]; then
        if [[ ! -s "$CONFIG" ]]; then
            echo "No directories to select."
            exit 1
        fi
        TARGET=$(sk < "$CONFIG") || exit 0
        [[ -z "$TARGET" ]] && echo "No directory selected" && exit 1
        tmux switch-client -c "$TARGET"
        exit 0
    elif [[ $# == 1 ]]; then
        tmux switch-client -c "$EXTERNAL_TARGET"
        exit 0
    else
        echo "Invalid number of arguments. We need 0 to 1 extra argument, you entered " "$($# - 1)"
        exit 1
    fi
}

if [ -n "$TMUX" ]; then
    # tmux new-window -n TMXD
    if [[ $# == 0 ]]; then
        echo "Please insert some flag..."
        exit 1
    fi
    if [[ $# -gt 2 ]]; then
        echo "Invalid number of arguments. We need 0 to 2, you entered " $#
    else
        case $1 in
            -ap|--append-dir)
            append_dir "$2"
            ;;
            -de|--delete-dir)
            delete_dir "$2"
            ;;
            -ed|--edit-dir)
            if [[ $# -gt 1 ]]; then
                echo "Invalid number of arguments FOR THIS FLAG. We need 0 extra argument."
                echo "You entered $(( $# - 1 )) extra arguments"
            else
                edit_dir
            fi
            ;;
            -se|--select-dir)
            if [[ $# -gt 1 ]]; then
                echo "Invalid number of arguments FOR THIS FLAG. We need 0 extra argument."
                echo "You entered $(( $# - 1 )) extra arguments"
            else
                # select_dir "$@"
                echo "Must be in a TMUX session..."
            fi
            ;;
            *)
            echo "Unknown option $1"
            exit 1
            ;;
        esac
    fi
    tmux kill-window -t TMXD 2>/dev/null

else
    if [[ $# == 0 ]]; then
            echo "Please insert some flag..."
            exit 1
    fi
    if [[ $# -gt 2 ]]; then
        echo "Invalid number of arguments. We need 0 to 2, you entered " $#
    else
        case $1 in
            -ap|--append-dir)
            append_dir "$2"
            ;;
            -de|--delete-dir)
            delete_dir "$2"
            ;;
            -ed|--edit-dir)
            if [[ $# -gt 1 ]]; then
                echo "Invalid number of arguments FOR THIS FLAG. We need 0 extra argument."
                echo "You entered $(( $# - 1 )) extra arguments"
            else
                edit_dir
            fi
            ;;
            -se|--select-dir)
            if [[ $# -gt 1 ]]; then
                echo "Invalid number of arguments FOR THIS FLAG. We need 0 extra argument."
                echo "You entered $(( $# - 1 )) extra arguments"
            else
                select_dir "$@"
            fi
            ;;
            *)
            echo "Unknown option $1"
            exit 1
            ;;
        esac
    fi
fi
