{ config, lib, pkgs, ... }:

{
    options.i3.enable = lib.mkEnableOption "Enable i3 window manager config";

    config = lib.mkIf config.i3.enable {
        home.packages = with pkgs; [
            i3
            i3lock-color
        ];

        xsession.windowManager.i3 = {
        enable = true;
        configFile = ../../dotfiles/i3/config;
        };
    };
}

