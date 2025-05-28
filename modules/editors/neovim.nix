{ config, pkgs, ... }:

let
  configDir = "${config.home.homeDirectory}/.config/nvim";
in {
  home.packages = with pkgs; [
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
    nil
    nixpkgs-fmt
    # Rust
    rust-analyzer
    rustfmt
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
  };
}

