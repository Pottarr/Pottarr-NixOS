#!/usr/bin/env bash
# Get current pane's working directory
dir=$(tmux display -p "#{pane_current_path}")

# Get the repo's remote URL
url=$(git -C "$dir" remote get-url origin 2>/dev/null)

if [[ -z "$url" ]]; then
    echo "Not a Git repository"
    exit 1
fi

# If it's SSH, convert to HTTPS
if [[ $url =~ ^git@github\.com:(.*)\.git$ ]]; then
    url="https://github.com/${BASH_REMATCH[1]}"
elif [[ $url =~ ^https://github\.com/(.*)\.git$ ]]; then
    # Strip .git for cleaner URL
    url="https://github.com/${BASH_REMATCH[1]}"
fi

# Open in Chrome
google-chrome-stable --new-window "$url" & disown 
