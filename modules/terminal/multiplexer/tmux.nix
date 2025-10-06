
{ ... }:

let
    dotfiles = ../../../dotfiles;
in {
    # Copy your tmux config file
    home.file.".config/tmux/tmux.conf".source = "${dotfiles}/tmux/tmux.conf";
    home.file.".config/tmux/open_github.sh".source = "${dotfiles}/scripts/tmux/open_github.sh";
    home.file.".config/tmux/open_github.sh".executable = true;
    home.file.".local/bin/tmx".source = "${dotfiles}/scripts/tmux/tmux_manage_session.sh";
    home.file.".local/bin/tmx".executable = true;
}

