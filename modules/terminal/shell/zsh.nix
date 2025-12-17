{ pkgs, ... }:

let
    dotfiles = ../../../dotfiles;
in {
    programs.zsh = {
        # enable = true;

        oh-my-zsh = {
            enable = true;
            # theme = "powerlevel10k/powerlevel10k";
            plugins = [ "git" "sudo" ];
            # custom = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
            theme = "powerlevel10k/powerlevel10k";
            custom = "${pkgs.zsh-powerlevel10k}/share/zsh-theme-powerlevel10k";
        };
        # shellInit = ''
        #     source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        # '';
        # Add your custom shell content here (like you'd do in .zshrc)
        initContent = ''
            # Load p10k config if present
            [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

            # Export extra stuff
            export PATH="$HOME/.local/bin:$PATH"
        '';
    };
    home.file.".zshrc".source = "${dotfiles}/zsh/.zshrc";


    home.packages = with pkgs; [
        zsh-powerlevel10k
    ];
}
