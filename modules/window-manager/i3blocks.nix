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
        home.file.".config/i3blocks/date" = {
            source = "${dotfiles}/i3blocks/date";
            executable = true;
        };
        home.file.".config/i3blocks/capslock" = {
            source = "${dotfiles}/i3blocks/capslock";
            executable = true;
        };
        home.file.".config/i3blocks/numlock" = {
            source = "${dotfiles}/i3blocks/numlock";
            executable = true;
        };
        home.file.".config/i3blocks/mic" = {
            source = "${dotfiles}/i3blocks/mic";
            executable = true;
        };
        home.file.".config/i3blocks/keyboard-layout" = {
            source = "${dotfiles}/i3blocks/keyboard-layout";
            executable = true;
        };
        home.file.".config/i3blocks/display-menu" = {
            source = "${dotfiles}/i3blocks/display-menu";
            executable = true;
        };
        home.file.".config/i3blocks/display-menu.py" = {
            source = "${dotfiles}/i3blocks/display-menu.py";
            executable = true;
        };
        home.file.".config/i3blocks/calendar-dropdown.py" = {
            source = "${dotfiles}/i3blocks/calendar-dropdown.py";
            executable = true;
        };
    };
}
