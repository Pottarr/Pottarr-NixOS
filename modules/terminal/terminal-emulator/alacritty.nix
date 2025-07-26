{ ... }:

let
    dotfiles = ../../../dotfiles;
in {
    # Copy your alacirtty config file
    home.file.".config/alacirtty/alacirtty.toml".source = "${dotfiles}/alacritty/alacirtty.toml";

    # Copy your alacirtty theme file
    home.file.".config/alacirtty/themes/gruber_darker.toml".source = "${dotfiles}/alacritty/themes/gruber_darker.toml";
}

