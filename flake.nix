{
    description = "Pottarr's Nix Flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, ... }:
        let
            system = "x86_64-linux";
            pkgs = import nixpkgs { inherit system; };
        in {
            # -------------------------------
            # NixOS Configurations (per host)
            # -------------------------------
            nixosConfigurations = {
            Siri = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [
                    ./hosts/Siri/configuration.nix
                    ./hosts/Siri/hardware-configuration.nix

                    # Enable home-manager as a NixOS module
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.pottarr = import ./users/pottarr/home.nix;
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
                        home-manager.users.pottarr = import ./users/pottarr/home.nix;
                    }
                ];
            };
        };

        # -------------------------------
        # Standalone Home Manager Config
        # -------------------------------
        homeConfigurations = {
            pottarr = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./users/pottarr/home.nix ];
            };
        };
    };
}

