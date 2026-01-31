# {
#     description = "Pottarr's Nix Flake";
#
#     inputs = {
#         nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
#         home-manager = {
#             url = "github:nix-community/home-manager/release-25.11";
#             inputs.nixpkgs.follows = "nixpkgs";
#         };
#         tmxds.url = "github:Pottarr/TMXDS";
#     };
#
#     outputs = { inputs, ... }:
#         let
#             system = "x86_64-linux";
#         in {
#             # -------------------------------
#             # NixOS Configurations (per host)
#             # -------------------------------
#             nixosConfigurations = {
#             Siri = inputs.nixpkgs.lib.nixosSystem {
#                 inherit system;
#                 modules = [
#                     ./hosts/Siri/configuration.nix
#                     ./hosts/Siri/hardware-configuration.nix
#
#                     # Enable home-manager as a NixOS module
#                     # inputs.home-manager.nixosModules.home-manager {
#                     #     home-manager.useGlobalPkgs = true;
#                     #     home-manager.useUserPackages = true;
#                     #     home-manager.users.pottarr = import ./users/pottarr/home.nix;
#                     #     home-manager.extraSpecialArgs = { inherit inputs; };
#                     # }
#                 ];
#             };
#
#             Tofu = inputs.nixpkgs.lib.nixosSystem {
#                 inherit system;
#                 modules = [
#                     ./hosts/Tofu/configuration.nix
#                     ./hosts/Tofu/hardware-configuration.nix
#
#                     # inputs.home-manager.nixosModules.home-manager {
#                     #     home-manager.useGlobalPkgs = true;
#                     #     home-manager.useUserPackages = true;
#                     #     home-manager.users.pottarr = import ./users/pottarr/home.nix;
#                     #     home-manager.extraSpecialArgs = { inherit inputs; };
#                     # }
#                 ];
#             };
#         };
#
#         # -------------------------------
#         # Standalone Home Manager Config
#         # -------------------------------
#         homeConfigurations = {
#             pottarr = inputs.home-manager.lib.homeManagerConfiguration {
#                 pkgs = import inputs.nixpkgs { inherit system; };
#                 extraSpecialArgs = { inherit inputs; };
#                 modules = [ ./users/pottarr/home.nix ];
#             };
#         };
#     };
# }




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
                ];
            };

            Tofu = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [
                    ./hosts/Tofu/configuration.nix
                    ./hosts/Tofu/hardware-configuration.nix
                ];
            };
        };

        homeConfigurations = {
            pottarr = home-manager.lib.homeManagerConfiguration {
                pkgs = import nixpkgs { inherit system; };
                extraSpecialArgs = {
                    inherit tmxds;
                };
                modules = [ ./users/pottarr/home.nix ];
            };
        };
    };
}

