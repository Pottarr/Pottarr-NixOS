{ pkgs, ... }:
{
    home = {
        username = "pottarr";
        homeDirectory = "/home/pottarr";
        stateVersion = "25.05";
        packages = with pkgs; [ dconf ];

        file.".config/nvim" = {
            source = builtins.path {
            name = "NeoVim-Config";
            path = ../../dotfiles/nvim;
            };
        };
    };

    imports = [
        ../../modules/editors/neovim.nix
        ../../modules/terminal/terminal.nix
        ../../modules/screenshot/screenshot.nix
        ../../modules/window-manager/i3.nix
        ../../modules/window-manager/i3blocks.nix
        ../../modules/gestures/fusuma.nix
    ];

    i3.enable = true;
    i3blocks.enable = true;

    programs.neovim = {
        enable = true;
        extraPackages = with pkgs; [
        lua5_4
        ];
    };

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
}
