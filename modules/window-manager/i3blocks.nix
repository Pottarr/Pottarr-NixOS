{ config, pkgs, lib, ... }:

let
    cfg = config.i3blocks;
    dotfiles = ../../dotfiles;
    homeDir = config.home.homeDirectory;
in
{
    options.i3blocks.enable = lib.mkEnableOption "Enable i3blocks config";
    config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [ i3blocks ];

        home.file.".config/i3blocks/config".source = "${dotfiles}/i3blocks/config";
        home.file.".config/i3blocks/battery".source = "${dotfiles}/i3blocks/battery";
        home.file.".config/i3blocks/disk".source = "${dotfiles}/i3blocks/disk";
        home.file.".config/i3blocks/calendar".source = "${dotfiles}/i3blocks/calendar";

        home.activation.makeI3blocksScriptsExecutable = lib.hm.dag.entryAfter ["writeBoundary"] ''
            chmod +x ${homeDir}/.config/i3blocks/config
            chmod +x ${homeDir}/.config/i3blocks/battery
            chmod +x ${homeDir}/.config/i3blocks/disk
            chmod +x ${homeDir}/.config/i3blocks/calendar
        '';

        # xsession.windowManager.i3.config.bars = [
        #     {
        #     position = "top";
        #     statusCommand = "i3blocks";
        #     }
        # ];
    };
}
