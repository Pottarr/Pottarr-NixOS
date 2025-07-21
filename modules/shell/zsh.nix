# { pkgs, ... }: {
{ ... }: {
    programs.zsh = {
        enable = true;

        oh-my-zsh = {
            enable = true;
            # theme = "powerlevel10k/powerlevel10k";
            plugins = [ "git" ];
            # custom = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
        };
        # shellInit = ''
        #     source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        # '';
    };

    # home.packages = with pkgs; [
        # zsh-powerlevel10k
    # ];
}
