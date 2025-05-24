{ config, pkgs, lib, ... }:

{
  home.username = "pottarr";
  home.homeDirectory = "/home/pottarr";

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    dconf
    glib
    gvfs
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      # package = pkgs.adwaita-theme;
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = lib.hm.gvariant.mkVariant "prefer-dark";
        # gtk-theme = lib.hm.gvariant.mkVariant "Adwaita-dark";
      };
    };
  };

  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
  };


  qt = {
    enable = true;
    platformTheme.name = "gtk"; # Makes Qt apps follow GTK theme
  };

  home.sessionVariables = {
    XDG_DATA_DIRS = lib.makeSearchPath "share" [
      pkgs.glib
      pkgs.gtk3
      pkgs.gtk4
    ] + ":/run/current-system/sw/share";
  };

}
