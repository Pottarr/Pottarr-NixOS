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

    #     xsession.windowManager.i3 = {
    #     enable = true;
    #     config = ../../dotfiles/i3/config;
    #     };
        # Copy your manual i3 config file
        home.file.".config/i3/config".source = "${dotfiles}/i3/config";

        # (Optional) Copy lock script if needed
        home.file.".config/i3/lock.sh".source = "${dotfiles}/i3/lock.sh";

        # (Optional) Make lock script executable
        home.activation.makeI3LockExecutable = lib.hm.dag.entryAfter ["writeBoundary"] ''
        chmod +x ${config.home.homeDirectory}/.config/i3/lock.sh
        '';
    };

    
}

