{
    description = "Pottarr's Nix Flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

        home-manager = {
        url = "github:nix-community/home-manager/release-25.11";
        inputs.nixpkgs.follows = "nixpkgs";
        };

        tmxds.url = "github:Pottarr/TMXDS";
    };

    outputs = { nixpkgs, home-manager, tmxds, ... }:
    let
        system = "x86_64-linux";
    in {
        nixosConfigurations = {
        Siri = nixpkgs.lib.nixosSystem {
            inherit system;

            modules = [
            ./hosts/Siri/configuration.nix
            ./hosts/Siri/hardware-configuration.nix

            # ✅ Home Manager as NixOS module
            home-manager.nixosModules.home-manager

            {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = {
                inherit tmxds;
                };

                home-manager.users.pottarr =
                import ./users/pottarr/home.nix;
            }
            ];
        };

        Tofu = nixpkgs.lib.nixosSystem {
            inherit system;

            modules = [
            ./hosts/Tofu/configuration.nix
            ./hosts/Tofu/hardware-configuration.nix

            home-manager.nixosModules.home-manager

            {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = {
                inherit tmxds;
                };

                home-manager.users.pottarr =
                import ./users/pottarr/home.nix;
            }
            ];
        };
        };
    };
}

