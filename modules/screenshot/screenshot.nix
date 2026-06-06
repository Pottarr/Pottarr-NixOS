{ config, pkgs, lib, ... }:

let
    dotfiles = ../../dotfiles;
in 
{
    options.screenshot.enable = lib.mkEnableOption "Enable screenshot script dependencies";

    config = lib.mkIf config.screenshot.enable {
        home.packages = with pkgs; [
            imagemagick
            xclip
            xdotool
            slop
            libnotify
            (python3.withPackages (ps: [ ps.wxpython ]))
        ];

        home.file.".local/bin/screenshot".source = "${dotfiles}/scripts/screenshot.sh";
        home.file.".local/bin/screenshot".executable = true;

        home.file.".local/bin/screenshot-tray".source = "${dotfiles}/scripts/screenshot_tray.py";
        home.file.".local/bin/screenshot-tray".executable = true;
    };
}
