{ pkgs, ... }:

let
    dotfiles = ../../../dotfiles;
in {
    home.packages = [ pkgs.neomutt ];

    # Copy your neomutt config file
    home.file.".config/neomutt/neomuttrc".source = "${dotfiles}/neomutt/neomuttrc";
}
