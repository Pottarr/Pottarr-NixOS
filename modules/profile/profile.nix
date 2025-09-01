{ ... }:

{
    nix.settings.allow-import-from-derivation = true;
    home.file.".face".source = builtins.fetchurl {
    url = "https://github.com/pottarr.png";
    sha256 = "sha256-CI2GKkkQ+prbHsq0Di7rdpRI9bTTtlL7Lm6kFbFXfLo=";
    };

}

# { pkgs, ... }:
#
# {
#   environment.var."AccountsService/icons/pottarr".source = pkgs.fetchurl {
#     url = "https://github.com/pottarr.png";
#     sha256 = "sha256-CI2GKkkQ+prbHsq0Di7rdpRI9bTTtlL7Lm6kFbFXfLo=";
#   };
#
#   environment.var."AccountsService/users/pottarr".text = ''
#     [User]
#     Icon=/var/lib/AccountsService/icons/pottarr
#   '';
# }
#
