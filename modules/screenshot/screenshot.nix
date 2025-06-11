{ config, pkgs, lib, ... }:

{
    options.screenshot.enable = lib.mkEnableOption "Enable screenshot script dependencies";

    config = lib.mkIf config.screenshot.enable {
        home.packages = with pkgs; [
            imagemagick
            xclip
            xdotool
            slop
            libnotify
        ];

        home.file.".local/bin/screenshot".source = ../../dotfiles/scripts/screenshot.sh;
        home.file.".local/bin/screenshot".executable = true;
    };
}
