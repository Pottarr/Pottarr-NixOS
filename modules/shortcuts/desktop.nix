{ ... }:

let
    dotfiles = ../../dotfiles;
in {
    home.file.".local/share/applications/Microsoft-Teams.desktop".source = "${dotfiles}/desktop/Microsoft-Teams.desktop";
    home.file.".local/share/applications/Microsoft-Teams.desktop".executable = true;
}

