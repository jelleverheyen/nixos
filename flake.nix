{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs =
    { ... }@inputs:
    {
      nixosConfigurations = {
        gertrude = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          system = "x86_64-linux";
          modules = [
            ./hosts/gertrude/configuration.nix
            ./modules/system
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jelle = import ./hosts/gertrude/home.nix;
            }
          ];
        };
      };
      #      nixosConfigurations = {
      #        gertrude = mkSystem ./hosts/gertrude/configuration.nix;
      #      };
      #
      #      homeConfigurations = {
      #        "jelle@gertrude" = mkHome "x86_64-linux" ./hosts/gertrude/home.nix;
      #      };
    };
}
