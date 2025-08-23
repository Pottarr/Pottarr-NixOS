{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Assembly
    nasm
    # Bash
    bash-language-server
    shfmt
    # C C++
    # Use Mason
    clang-tools
    # Go
    go
    # Use Mason
    gopls
    # HTML
    nodePackages.live-server
    # Java
    # Use Mason
    jdt-language-server
    # Lua
    # Use Mason
    lua-language-server
    stylua
    # Nix
    nixd
    nixpkgs-fmt
    # Python
    # Use Mason
    pyright
    black
    # Rust
    # Use Mason
    rust-analyzer
    rustfmt
    # Typescript
    # Use Mason
    typescript-language-server
    nodePackages.prettier
  ];

  programs.neovim = {
    enable = true;
  };
}

