{ ... }:

{
    imports = [
        ./mail-client/neomutt.nix
        ./multiplexer/tmux.nix
        ./shell/zsh.nix
        ./terminal-emulator/alacritty.nix
        ./terminal-emulator/ghostty.nix
    ];
}
