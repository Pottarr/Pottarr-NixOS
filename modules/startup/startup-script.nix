# { config, pkgs, lib, ... }:
{ pkgs, ... }:

let
    dotfiles = ../../dotfiles;
in {
    environment.etc."ELECOM.sh".source = "${dotfiles}/scripts/ELECOM.sh";
}

