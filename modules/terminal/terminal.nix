{ ... }:

{
    imports = [
        ./terminal-emulator/alacritty.nix
        ./terminal-emulator/ghostty.nix
        ./multiplexer/tmux.nix
        ./shell/zsh.nix
    ];
}
