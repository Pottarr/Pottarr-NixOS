{ pkgs, ... }:

let
    dotfiles = ../../dotfiles;
in {
    services.fusuma = {
        enable = true;
        package = with pkgs; [
            fusuma
        ];
    };
    # Copy your alacirtty config file
    home.file.".config/fusuma/config.yml".source = "${dotfiles}/fusuma/config.yml";
}

