
{ ... }:

let
    dotfiles = ../../dotfiles;
in {
    # Copy your tmux config file
    home.file.".config/tmux/tmux.conf".source = "${dotfiles}/alacritty/alacirtty.toml";
}

