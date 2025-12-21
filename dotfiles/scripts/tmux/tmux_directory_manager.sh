#!/usr/bin/env bash
#
#CONFIG="$HOME/.config/tmux/dir_list"
#
## append_dir() {
##     if [[ ! -f "$CONFIG" ]]; then
##         mkdir -p "$(dirname "$CONFIG")"
##         touch "$CONFIG"
##     fi
##     local TARGET
##     if [[ $# == 0 ]]; then
##         TARGET="$PWD"
##     elif [[ $# == 1 ]]; then
##         # TARGET=$(fd --type=directory --absolute-path . "$1" | fzf)
##         # TARGET=$(fd --type d . "$1" -0 | fzf --read0 | xargs -0 realpath)
##         TARGET=$(fd --type d . "$1" | fzf)
##         TARGET=$(realpath "$TARGET")
##     elif [[ $# == 2 ]]; then
##         case $1 in
##             -xd|-exact-directory)
##             TARGET=$(realpath "$2")
##             ;;
##             *)
##             echo "Unknown option $1"
##             exit 1
##             ;;
##         esac
##     else
##         echo "Invalid number of arguments. We need 0 to 1, you entered " $#
##         exit 1
##     fi
##     if ! rg -q -N -U -F -x  "$TARGET" "$CONFIG"; then
##         echo "$TARGET" >> "$CONFIG"
##         echo "Added $TARGET to the list..."
##         exit 0
##     else
##         echo "Directory already existed..."
##         exit 1
##     fi
## }
#
#
#
#append_dir() {
#    if [[ ! -f "$CONFIG" ]]; then
#        mkdir -p "$(dirname "$CONFIG")"
#        touch "$CONFIG"
#    fi
#
#    local TARGET
#
#    case $# in
#        0)
#            TARGET="$PWD"
#            ;;
#
#        1)
#            TARGET=$(fd --type d . "$1" | fzf)
#            [[ -n "$TARGET" ]] || return 1
#            TARGET=$(realpath "$TARGET")
#            ;;
#
#        2)
#            case "$1" in
#                -xd|-exact-directory)
#                    TARGET=$(realpath "$2")
#                    ;;
#                *)
#                    echo "Unknown option: $1" >&2
#                    return 1
#                    ;;
#            esac
#            ;;
#
#        *)
#            echo "Usage: append_dir [path] | append_dir -xd <dir>" >&2
#            return 1
#            ;;
#    esac
#
#    if ! rg -q -F -x "$TARGET" "$CONFIG"; then
#        echo "$TARGET" >> "$CONFIG"
#        echo "Added $TARGET to the list."
#        return 0
#    else
#        echo "Directory already exists."
#        return 1
#    fi
#}
#
#
#delete_dir() {
#    if [[ ! -f "$CONFIG" ]]; then
#        echo "File does not exist: $CONFIG"
#        echo "No directory to delete..."
#        exit 1
#    fi
#    local TARGET=""
#    if [[ $# == 0 ]]; then
#        if [[ ! -s "$CONFIG" ]]; then
#            echo "No directories to select."
#            exit 1
#        fi
#        if [[ -n "$TARGET" ]]; then
#            local ESC
#            ESC=$(printf '%s\n' "$TARGET" | sed 's/[\/&]/\\&/g')
#            sed -i "/$ESC/d" "$CONFIG"
#            echo "Directory already existed..."
#            exit 0
#        else
#            echo "No directory selected..."
#            exit 1
#        fi
#    elif [[ $# == 1 ]]; then
#        TARGET="$1"
#        if rg -q -N -U -i "$TARGET" "$CONFIG"; then
#            local ESC
#            ESC=$(printf '%s\n' "$TARGET" | sed 's/[\/&]/\\&/g')
#            sed -i "/$ESC/d" "$CONFIG"
#            echo "Deleted ${TARGET} from the list..."
#        fi
#    else
#        echo "Invalid number of arguments. We need 0 to 1, you entered " $#
#        exit 1
#    fi
#}
#
#edit_dir() {
#    nvim "$CONFIG"
#    exit 0
#}
#
#select_dir() {
#    if [[ ! -f "$CONFIG" ]]; then
#        echo "File does not exist: $CONFIG"
#        echo "No directory to select..."
#        exit 1
#    fi
#    local TARGET=""
#    local EXTERNAL_TARGET="$1"
#    if [[ $# == 0 ]]; then
#        if [[ ! -s "$CONFIG" ]]; then
#            echo "No directories to select."
#            exit 1
#        fi
#        TARGET=$(sk < "$CONFIG") || exit 0
#        [[ -z "$TARGET" ]] && echo "No directory selected" && exit 1
#        tmux switch-client -c "$TARGET"
#        exit 0
#    elif [[ $# == 1 ]]; then
#        tmux switch-client -c "$EXTERNAL_TARGET"
#        exit 0
#    else
#        echo "Invalid number of arguments. We need 0 to 1 extra argument, you entered " "$($# - 1)"
#        exit 1
#    fi
#}
#
#if [ -n "$TMUX" ]; then
#    # tmux new-window -n TMXD
#    if [[ $# == 0 ]]; then
#        echo "Please insert some flag..."
#        exit 1
#    fi
#    if [[ $# -gt 2 ]]; then
#        echo "Invalid number of arguments. We need 0 to 2, you entered " $#
#    else
#        case $1 in
#            -ap|--append-dir)
#            append_dir "$2"
#            ;;
#            -de|--delete-dir)
#            delete_dir "$2"
#            ;;
#            -ed|--edit-dir)
#            if [[ $# -gt 1 ]]; then
#                echo "Invalid number of arguments FOR THIS FLAG. We need 0 extra argument."
#                echo "You entered $(( $# - 1 )) extra arguments"
#            else
#                edit_dir
#            fi
#            ;;
#            -se|--select-dir)
#            if [[ $# -gt 1 ]]; then
#                echo "Invalid number of arguments FOR THIS FLAG. We need 0 extra argument."
#                echo "You entered $(( $# - 1 )) extra arguments"
#            else
#                # select_dir "$@"
#                echo "Must be in a TMUX session..."
#            fi
#            ;;
#            *)
#            echo "Unknown option $1"
#            exit 1
#            ;;
#        esac
#    fi
#    tmux kill-window -t TMXD 2>/dev/null
#
#else
#    if [[ $# == 0 ]]; then
#            echo "Please insert some flag..."
#            exit 1
#    fi
#    if [[ $# -gt 2 ]]; then
#        echo "Invalid number of arguments. We need 0 to 2, you entered " $#
#    else
#        case $1 in
#            -ap|--append-dir)
#            append_dir "$2"
#            ;;
#            -de|--delete-dir)
#            delete_dir "$2"
#            ;;
#            -ed|--edit-dir)
#            if [[ $# -gt 1 ]]; then
#                echo "Invalid number of arguments FOR THIS FLAG. We need 0 extra argument."
#                echo "You entered $(( $# - 1 )) extra arguments"
#            else
#                edit_dir
#            fi
#            ;;
#            -se|--select-dir)
#            if [[ $# -gt 1 ]]; then
#                echo "Invalid number of arguments FOR THIS FLAG. We need 0 extra argument."
#                echo "You entered $(( $# - 1 )) extra arguments"
#            else
#                select_dir "$@"
#            fi
#            ;;
#            *)
#            echo "Unknown option $1"
#            exit 1
#            ;;
#        esac
#    fi
#fi

CONFIG="$HOME/.config/tmux/dir_list"

# --------------------------------------------------
# Append directory
# --------------------------------------------------
append_dir() {
    [[ -f "$CONFIG" ]] || {
        mkdir -p "$(dirname "$CONFIG")"
        touch "$CONFIG"
    }

    local TARGET

    case $# in
        1)
            TARGET="$PWD"
            ;;
        2)
            TARGET=$(fd --type d . "$2" | fzf) || return 1
            [[ -n "$TARGET" ]] || return 1
            TARGET=$(realpath "$TARGET")
            ;;
        3)
            case "$2" in
                -xd|--exact-directory)
                    TARGET=$(realpath "$3")
                    [[ -n "$TARGET" ]] || return 1
                    ;;
                *)
                    echo "Unknown option: $2" >&2
                    return 1
                    ;;
            esac
            ;;
        *)
            echo "Usage: append_dir [path] | append_dir -xd <dir>" >&2
            return 1
            ;;
    esac

    [[ -d "$TARGET" ]] || {
        echo "Not a directory: $TARGET" >&2
        return 1
    }

    if ! rg -q -F -x "$TARGET" "$CONFIG"; then
        echo "$TARGET" >> "$CONFIG"
        echo "Added $TARGET"
    else
        echo "Directory already exists"
        return 1
    fi
}

# --------------------------------------------------
# Delete directory
# --------------------------------------------------
delete_dir() {
    [[ -f "$CONFIG" ]] || {
        echo "No directory list exists."
        return 1
    }

    local TARGET ESC

    case $# in
        0)
            [[ -s "$CONFIG" ]] || {
                echo "No directories to delete."
                return 1
            }
            TARGET=$(sk < "$CONFIG") || return 1
            [[ -n "$TARGET" ]] || return 1
            ;;
        1)
            TARGET="$1"
            ;;
        *)
            echo "Usage: delete_dir [directory]" >&2
            return 1
            ;;
    esac

    if ! rg -q -F -x "$TARGET" "$CONFIG"; then
        echo "Directory not found."
        return 1
    fi

    ESC=$(printf '%s\n' "$TARGET" | sed 's/[\/&]/\\&/g')
    sed -i "/^$ESC$/d" "$CONFIG"
    echo "Deleted $TARGET"
}

# --------------------------------------------------
# Edit list
# --------------------------------------------------
edit_dir() {
    nvim "$CONFIG"
}

# --------------------------------------------------
# Select directory (tmux only)
# --------------------------------------------------
select_dir() {
    [[ -n "$TMUX" ]] || {
        echo "Must be inside a tmux session."
        return 1
    }

    [[ -f "$CONFIG" && -s "$CONFIG" ]] || {
        echo "No directories to select."
        return 1
    }

    local TARGET

    case $# in
        0)
            TARGET=$(sk < "$CONFIG") || return 1
            [[ -n "$TARGET" ]] || return 1
            ;;
        1)
            TARGET="$1"
            ;;
        *)
            echo "Usage: select_dir [directory]" >&2
            return 1
            ;;
    esac

    tmux switch-client -c "$TARGET"
}

# --------------------------------------------------
# CLI
# --------------------------------------------------
if [[ $# -eq 0 ]]; then
    echo "Usage:"
    echo "  -ap | --append-dir [path]"
    echo "  -de | --delete-dir [path]"
    echo "  -ed | --edit-dir"
    echo "  -se | --select-dir [path]"
    exit 1
fi

case "$1" in
    -ap|--append-dir)
        append_dir "$@"
        ;;
    -de|--delete-dir)
        delete_dir "$2"
        ;;
    -ed|--edit-dir)
        [[ $# -eq 1 ]] || {
            echo "edit-dir takes no arguments" >&2
            exit 1
        }
        edit_dir
        ;;
    -se|--select-dir)
        select_dir "$2"
        ;;
    *)
        echo "Unknown option: $1" >&2
        exit 1
        ;;
esac

