{ ... }:

let
    dotfiles = ../../../dotfiles;
in {
    # Copy your alacirtty config file
    home.file.".config/ghostty/config".source = "${dotfiles}/ghostty/config";
}

