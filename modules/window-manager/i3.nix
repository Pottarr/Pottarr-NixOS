{ config, lib, pkgs, ... }:

let
    dotfiles = ../../dotfiles;
in {
    options.i3.enable = lib.mkEnableOption "Enable i3 window manager config";

    config = lib.mkIf config.i3.enable {
        home.packages = with pkgs; [
            i3
            i3lock-color
        ];

        # .config/i3

        home.file.".config/i3/config" = {
            source = "${dotfiles}/i3/config";
            executable = true;
        };
        home.file.".config/i3/volume_notification.sh" = {
            source = "${dotfiles}/scripts/volume_notification.sh";
            executable = true;
        };
        home.file.".config/i3/brightness_notification.sh" = {
            source = "${dotfiles}/scripts/brightness_notification.sh";
            executable = true;
        };
        home.file.".config/i3/battery-notification/battery_notification.sh" = {
        source = "${dotfiles}/scripts/battery-notification/battery_notification.sh";
            executable = true;
        };
        home.file.".config/i3/battery-notification/icons/battery-low.svg" = {
            source = "${dotfiles}/scripts/battery-notification/icons/battery-low.svg";
            executable = true;
        };
        home.file.".config/i3/battery-notification/icons/battery-full.svg" = {
            source = "${dotfiles}/scripts/battery-notification/icons/battery-full.svg";
            executable = true;
        };
        home.file.".config/i3/battery-notification/icons/battery-full-charging.svg" = {
            source = "${dotfiles}/scripts/battery-notification/icons/battery-full-charging.svg";
            executable = true;
        };
        home.file.".config/i3/power_menu.sh" = {
            source = "${dotfiles}/scripts/power_menu.sh";
            executable = true;
        };
        home.file.".config/i3/xfce_display_settings.sh" = {
            source = "${dotfiles}/scripts/xfce_display_settings.sh";
            executable = true;
        };

        # .local

        home.file.".local/bin/ELECOM" = {
            source = "${dotfiles}/scripts/ELECOM.sh";
            executable = true;
        };
        home.file.".local/bin/screenshot" = {
            source = "${dotfiles}/scripts/screenshot.sh";
            executable = true;
        };
        home.file.".local/bin/fancy-lock-cmd" = {
            source = "${dotfiles}/scripts/lock.sh";
            executable = true;
        };
    };
}

