# { config, pkgs, lib, ... }:
{ pkgs, ... }:

let
    dotfiles = ../../dotfiles;
in {
  home.packages = with pkgs; [ fusuma ];

  xdg.configFile."fusuma/config.yml".source = "${dotfiles}/fusuma/config.yml";

  home.file.".local/share/applications/fusuma.desktop".text = ''
    [Desktop Entry]
    Name=Fusuma
    Exec=${pkgs.fusuma}/bin/fusuma -d
    Type=Application
  '';

  # Optional: run it at login
  xsession.windowManager.i3.config.startup = [
    {
      command = "${pkgs.fusuma}/bin/fusuma -d";
      always = true;
      notification = false;
    }
  ];
}

