{
    description = "Pottarr's Nix Flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

        home-manager = {
        url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        tmxds.url = "github:Pottarr/TMXDS";
        # antigravity.url = "github:jacopone/antigravity-nix";
    };

    outputs = { nixpkgs, home-manager, tmxds, ... }:
    let
        system = "x86_64-linux";
    in {
        nixosConfigurations = {
        Siri = nixpkgs.lib.nixosSystem {
            inherit system;

            specialArgs = {};

            modules = [
                {
                    nixpkgs = {
                        config = {
                        allowUnfree = true;
                        allowBroken = true;
                        # ciscoPacketTracerSource = /nix/store/6hjgf7b5vg9nqa4hl150pxdcs8xf4i15-CiscoPacketTracer822_amd64_signed.deb;
                        };
                    };
                }

                ./hosts/Siri/configuration.nix
                ./hosts/Siri/hardware-configuration.nix

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

