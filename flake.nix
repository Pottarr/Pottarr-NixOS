{

  description = "Pottarr's Nix Flake";

  inputs = {
    nixpkgs = {
      # url = "github:NixOS/nixpkgs/24.11";
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {  
    nixosConfigurations = {
      Siri = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ 
          ./hosts/Siri/configuration.nix
          ./hosts/Siri/hardware-configuration.nix
        ];
      };
    };
    homeConfigurations = {
      pottarr = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        username = "pottarr";
        modules = [ ./home.nix ];
      }; 
    };
  };
}
