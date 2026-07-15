{ config, lib, ... }:

let
  # Get paths for all normal users
  externalEntrypoints = lib.mapAttrsToList (name: user:
    /. + "${user.home}/Setups/NixOS-External/external.nix"
  ) (lib.filterAttrs (name: user: user.isNormalUser) config.users.users);
  
  # Global wildcard entrypoint broker for workspace scratch files
  wildcardEntrypoint = /home/pottarr/agy/src/12-07-2026-NixOS-External-Configurations-Guide/external.nix;
in
{
  imports = builtins.filter (path: builtins.pathExists path) (externalEntrypoints ++ [ wildcardEntrypoint ]);
}

