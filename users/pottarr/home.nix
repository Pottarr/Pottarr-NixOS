{ config, pkgs, tmxds, ... }:
{
    home = {
        username = "pottarr";
        homeDirectory = "/home/pottarr";
        stateVersion = "25.05";
        packages = with pkgs; [
            emote
            dconf-editor
            tmxds.packages.${pkgs.stdenv.hostPlatform.system}.default
            # X11 libraries
            xorg.libX11
            xorg.libXcursor
            xorg.libXi
            xorg.libXrandr
            libxkbcommon
            gnome-themes-extra
        ];
        sessionPath = [
            "$HOME/.local/bin"
        ];
    };

    home.file."logo".source = ../../dotfiles/logo;
    home.file.".config/fcitx5/profile".source = ../../dotfiles/fcitx5/profile;
    i3.enable = true;
    i3blocks.enable = true;
    services.picom.enable = true;
    imports = [
        ../../modules/editors/neovim.nix
        ../../modules/terminal/terminal.nix
        ../../modules/screenshot/screenshot.nix
        ../../modules/window-manager/i3.nix
        ../../modules/window-manager/i3blocks.nix
        ../../modules/obs/obs.nix
        ../../modules/shortcuts/desktop.nix
    ];
    screenshot.enable = true;

    programs.home-manager.enable = true;

    xdg.mime = {
        enable = true;
    };

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
        gtk3.extraConfig = {
            gtk-recent-files-enabled = 0;
        };
        gtk4.extraConfig = {
            gtk-recent-files-enabled = 0;
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

    xdg.configFile."fastfetch/config.jsonc".text = ''
        {
            "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
            "logo": {
                "source": "/home/pottarr/logo",
                "type": "auto",
                "padding": {
                    "top": 1,
                    "bottom": 0,
                    "left": 3,
                    "right": 3
                }
            },
            "modules": [
                "break",
                "title",
                "os",
                "host",
                "kernel",
                "uptime",
                "cpu",
                "gpu",
                "memory",
                "disk",
                "localip",
                "battery",
                "break"
            ]
        }
    '';
}
