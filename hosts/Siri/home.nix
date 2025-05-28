# { config, pkgs, lib, ... }:
{ config, pkgs, ... }:

{
  home = {
    username = "pottarr";
    homeDirectory = "/home/pottarr/";
    stateVersion = "25.05";
  };

  imports = [
    ../../modules/editors/neovim.nix
  ];

  programs.neovim = {
    enable = true;
    # package = pkgs.wrapNeovim pkgs.neovim-unwrapped {
    #   lua = pkgs.neovim-unwrapped.lua;
    #   # Optional: Add runtime dependencies like Python or Ruby here
    # };
    extraPackages = with pkgs; [
      lua5_4
    ];
  };


  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    dconf
    # glib
    # gvfs
  ];

  gtk = {
    enable = true;
    theme = {
      # name = "adw-gtk3";
      name = "Adwaita-dark";
      # package = pkgs.adw-gtk3;
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
  #   settings = {
  #     "org/gnome/desktop/interface" = {
  #       color-scheme = lib.hm.gvariant.mkVariant "prefer-dark";
  #       # gtk-theme = lib.hm.gvariant.mkVariant "Adwaita-dark";
  #     };
  #   };
  };
  #
  # home.sessionVariables = {
  #   GTK_THEME = "Adwaita-dark";
  # };
  
  home.file = {
    # "xdg/gtk-2.0/gtkrc".text = "gtk-application-prefer-dark-theme=1";
    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
    '';
    "xdg/gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
    '';
  };


  qt = {
    enable = true;
    platformTheme.name = "gtk"; # Makes Qt apps follow GTK theme
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  # home.sessionVariables = {
  #   XDG_DATA_DIRS = lib.makeSearchPath "share" [
  #     pkgs.glib
  #     pkgs.gtk3
  #     pkgs.gtk4
  #   ] + ":/run/current-system/sw/share";
  # };

}
