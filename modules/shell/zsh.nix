{ config, pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        oh-my-zsh = {
        enable = true;
        theme = "powerlevel10k/powerlevel10k";
        plugins = [ "git" ];
        custom = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
        };
        initContent = ''
        [[ -f ${config.home.homeDirectory}/dotfiles/powerlevel10k/.p10k.zsh ]] && source ${config.home.homeDirectory}/dotfiles//zsh/.p10k.zsh
        '';
    };

    home.file.".p10k.zsh".source = ./../../dotfiles/powerlevel10k/.p10k.zsh;

    home.packages = with pkgs; [
        zsh-powerlevel10k
    ];
}

