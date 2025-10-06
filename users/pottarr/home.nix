{ config, pkgs, ... }:
{
    home = {
        username = "pottarr";
        homeDirectory = "/home/pottarr";
        stateVersion = "25.05";
        packages = with pkgs; [
            dconf
            # X11 libraries
            xorg.libX11
            xorg.libXcursor
            xorg.libXi
            xorg.libXrandr
            libxkbcommon
        ];
    };

    i3.enable = true;
    i3blocks.enable = true;
    imports = [
        ../../modules/editors/neovim.nix
        ../../modules/terminal/terminal.nix
        ../../modules/screenshot/screenshot.nix
        ../../modules/window-manager/i3.nix
        ../../modules/window-manager/i3blocks.nix
        ../../modules/window-manager/picom.nix
        ../../modules/obs/obs.nix
    ];
    screenshot.enable = true;

    programs.home-manager.enable = true;

    gtk = {
        enable = true;
        theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
        };
        iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        };
    };

    dconf = {
        enable = true;
        settings = {
        "org/gnome/desktop/interface" = {
            "color-scheme" = "prefer-dark";
        };
        };
    };

    qt = {
        enable = true;
        platformTheme.name = "gtk"; # Makes Qt apps follow GTK theme
        style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
        };
    };

    xdg.userDirs = {
        enable = true;
        pictures = "${config.home.homeDirectory}/Pictures";
    };
}
