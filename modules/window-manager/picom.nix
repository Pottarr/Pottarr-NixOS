{ ... }:

let
    dotfiles = ../../dotfiles;
in
{
    services.picom.enable = true;
    xdg.configFile."picom/picom.conf".source = "${dotfiles}/picom/picom.conf";
}
