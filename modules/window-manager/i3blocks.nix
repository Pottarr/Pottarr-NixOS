{ config, lib, pkgs, ... }:

let
    scriptNames = [ "battery" "disk" ];
in
{
    options.i3blocks.enable = lib.mkEnableOption "Enable i3blocks config";

    config = lib.mkIf config.i3blocks.enable {
        home.packages = with pkgs; [ i3blocks ];

        xdg.configFile."i3blocks/config".source = ../../dotfiles/i3blocks/config;
    };
    home.file = builtins.listToAttrs (
        map (name: {
            name = ".local/bin/${name}";
            value = {
            source = ../scripts + "/${name}.sh";
            executable = true;
            };
        }) scriptNames
    );
}

