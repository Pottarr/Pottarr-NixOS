{ ... }:

let
    dotfiles = ../../dotfiles;
in
{
    services.picom.enable = true;
    xdg.configFile."picom/picom.conf".source = "${dotfiles}/picom/picom.conf";
    # home.file.".config/picom/picom.conf".source = "${dotfiles}/picom/picom.conf";
}
