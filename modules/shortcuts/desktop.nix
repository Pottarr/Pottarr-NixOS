{ ... }:

let
    dotfiles = ../../dotfiles;
in {
    home.file.".local/share/applications/Microsoft-Teams.desktop".source = "${dotfiles}/desktop/Microsoft-Teams.desktop";
    home.file.".local/share/applications/Microsoft-Teams.desktop".executable = true;
    home.file.".local/share/applications/open_qt_designer".source = "${dotfiles}/scripts/open_qt_designer.sh";
    home.file.".local/share/applications/open_qt_designer".executable = true;
    home.file.".local/share/applications/QT-Designer.desktop".source = "${dotfiles}/desktop/QT-Designer.desktop";
    home.file.".local/share/applications/QT-Designer.desktop".executable = true;
}

