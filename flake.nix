{
    description = "Pottarr's Nix Flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";
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
        IdeaPad = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
                ./hosts/IdeaPad/configuration.nix
                ./hosts/IdeaPad/hardware-configuration.nix

                # Enable home-manager as a NixOS module
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.pottarr = import ./users/pottarr/home.nix;
                }
            ];
        };

        ThinkPad = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
                ./hosts/ThinkPad/configuration.nix
                ./hosts/ThinkPad/hardware-configuration.nix

                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.pottarr = import ./users/pottarr/home.nix;
                }
            ];
        };

        BMAX = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
                ./hosts/BMAX/configuration.nix
                ./hosts/BMAX/hardware-configuration.nix

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

