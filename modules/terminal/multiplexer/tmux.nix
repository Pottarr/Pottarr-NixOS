
{ ... }:

let
    dotfiles = ../../../dotfiles;
in {
    # Copy your tmux config file
    home.file.".config/tmux/tmux.conf".source = "${dotfiles}/tmux/tmux.conf";
    home.file.".config/tmux/open_github.sh".source = "${dotfiles}/scripts/tmux/open_github.sh";
    home.file.".config/tmux/open_github.sh".executable = true;
    # home.file.".local/bin/tmxs".source = "${dotfiles}/scripts/tmux/tmux_session_manager.sh";
    # home.file.".local/bin/tmxs".executable = true;
    # home.file.".local/bin/tmxd".source = "${dotfiles}/scripts/tmux/tmux_directory_manager.sh";
    # home.file.".local/bin/tmxd".executable = true;
}

