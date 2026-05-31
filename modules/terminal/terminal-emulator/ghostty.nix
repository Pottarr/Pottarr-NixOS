{ ... }:

let
    dotfiles = ../../../dotfiles;
in {
    # Copy your alacirtty config file
    home.file.".config/ghostty/config.ghostty".source = "${dotfiles}/ghostty/config.ghostty";
}

