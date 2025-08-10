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

        home.file.".config/i3/config".source = "${dotfiles}/i3/config";

        home.file.".config/i3/lock.sh".source = "${dotfiles}/i3/lock.sh";
        home.file.".config/i3/volume_notification.sh".source = "${dotfiles}/scripts/volume_notification.sh";
        home.file.".config/i3/brightness_notification.sh".source = "${dotfiles}/scripts/brightness_notification.sh";
        home.file.".config/i3/battery-notification/battery_notification.sh".source = "${dotfiles}/scripts/battery-notification/battery_notification.sh";
        home.file.".config/i3/battery-notification/icons/battery-low.svg".source = "${dotfiles}/scripts/battery-notification/icons/battery-low.svg";
        home.file.".config/i3/battery-notification/icons/battery-full.svg".source = "${dotfiles}/scripts/battery-notification/icons/battery-full.svg";
        home.file.".config/i3/battery-notification/icons/battery-full-charging.svg".source = "${dotfiles}/scripts/battery-notification/icons/battery-full-charging.svg";
        home.file.".config/i3/power_menu.sh".source = "${dotfiles}/scripts/power_menu.sh";

        home.activation.makeI3LockExecutable = lib.hm.dag.entryAfter ["writeBoundary"] ''
        chmod +x ${config.home.homeDirectory}/.config/i3/lock.sh
        chmod +x ${config.home.homeDirectory}/.config/i3/volume_notification.sh
        chmod +x ${config.home.homeDirectory}/.config/i3/brightness_notification.sh
        chmod +x ${config.home.homeDirectory}/.config/i3/battery-notification/battery_notification.sh
        chmod +x ${config.home.homeDirectory}/.config/i3/power_menu.sh
        '';
    };

    
}

