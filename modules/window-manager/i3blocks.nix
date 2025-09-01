{ config, pkgs, lib, ... }:

let
    cfg = config.i3blocks;
    dotfiles = ../../dotfiles;
in
{
    options.i3blocks.enable = lib.mkEnableOption "Enable i3blocks config";

    config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [ i3blocks ];

        home.file.".config/i3blocks/config" = {
            source = "${dotfiles}/i3blocks/config";
            executable = true;
        };
        home.file.".config/i3blocks/battery" = {
            source = "${dotfiles}/i3blocks/battery";
            executable = true;
        };
        home.file.".config/i3blocks/disk" = {
            source = "${dotfiles}/i3blocks/disk";
            executable = true;
        };
        home.file.".config/i3blocks/rofi-calendar" = {
            source = "${dotfiles}/i3blocks/rofi-calendar";
            executable = true;
        };
    };
}
