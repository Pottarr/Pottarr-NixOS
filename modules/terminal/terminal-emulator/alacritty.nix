{ ... }:

let
    dotfiles = ../../../dotfiles;
in {
    # Copy your alacirtty config file
    home.file.".config/alacritty/alacritty.toml".source = "${dotfiles}/alacritty/alacritty.toml";

    # Copy your alacirtty theme file
    home.file.".config/alacritty/themes/gruber_darker.toml".source = "${dotfiles}/alacritty/themes/gruber_darker.toml";
}

