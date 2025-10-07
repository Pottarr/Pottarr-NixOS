{ ... }:

let
    dotfiles = ../../dotfiles;
in {
    home.file."Desktop/Microsoft-Teams.desktop".source = "${dotfiles}/desktop/Microsoft-Teams.desktop";
    home.file."Desktop/Microsoft-Teams.desktop".executable = true;
}

