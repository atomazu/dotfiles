{
  description = "My Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop/configuration.nix
          ./hosts/desktop/hardware-configuration.nix

          inputs.catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.default {
            home-manager = {
              extraSpecialArgs = { inherit inputs; };
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jonas = {
                imports = [
                  ./hosts/desktop/home.nix
                  inputs.catppuccin.homeManagerModules.catppuccin
                  inputs.nixvim.homeManagerModules.nixvim
                  inputs.nix-colors.homeManagerModules.default
                ];
              };
            };
          }
        ];
      };
    };
  }; 
}

