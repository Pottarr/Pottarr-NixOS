{
  description = "Pottarr's NixOS Flake";

  inputs = {
    # NixOS 25.11
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Home Manager 25.11 (stable, matches nixos release)
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
  in {
    # ---------------------------------------------
    # NixOS hosts
    # ---------------------------------------------
    nixosConfigurations = {
      IdeaPad = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/IdeaPad/configuration.nix
          ./hosts/IdeaPad/hardware-configuration.nix

          # Home Manager as a NixOS module
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

    # ---------------------------------------------
    # Standalone Home Manager (optional)
    # ---------------------------------------------
    homeConfigurations = {
      pottarr = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./users/pottarr/home.nix ];
      };
    };
  };
}

