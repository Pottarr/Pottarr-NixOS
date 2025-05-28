{ pkgs, ... }:
{
  home = {
    username = "pottarr";
    homeDirectory = "/home/pottarr/";
    stateVersion = "25.05";
    file = {
      ".config/nvim" = {
        source = builtins.path {
          name = "NeoVim Config";
          path = ../../dotfiles/nvim;
        };
      };

      "xdg/gtk-3.0/settings.ini".text = ''
        [Settings]
        gtk-application-prefer-dark-theme=1
      '';

      "xdg/gtk-4.0/settings.ini".text = ''
        [Settings]
        gtk-application-prefer-dark-theme=1
      '';
    };
    packages = with pkgs; [
      dconf
    ];
  };


  imports = [
    ../../modules/editors/neovim.nix
  ];

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      lua5_4
    ];
  };


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
