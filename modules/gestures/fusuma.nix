
{ ... }:

let
    dotfiles = ../../../dotfiles;
in {
    # Copy your alacirtty config file
    home.file.".config/fusuma/config.yml".source = "${dotfiles}/fusuma/config.yml";
}

