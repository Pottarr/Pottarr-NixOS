# { config, pkgs, ... }:
{ pkgs, ... }:

# let
#   configDir = "../../dotfiles/nvim/";
# in {
{
    home.packages = with pkgs; [
        # Assembly
        nasm
        # Bash
        bash-language-server
        shfmt
        # C C++
        clang-tools  # includes clangd & clang-format
        # Go
        go
        gopls
        # Lua
        lua-language-server
        stylua
        # Nix
        nixd
        nixpkgs-fmt
        # Python
        pyright
        black
        # Rust
        rust-analyzer
        rustfmt
        # Typescript
        typescript-language-server
        nodePackages.prettier
    ];

    programs.neovim = {
        enable = true;
        # package = pkgs.neovim;
    };
}

