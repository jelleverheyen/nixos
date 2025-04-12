{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    { ... }@inputs:
    {
      nixosConfigurations = {
        gertrude = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit inputs;
          };

          modules = [
            ./hosts/gertrude/configuration.nix
            ./modules/system
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.jelle = {
                imports = [
                  ./hosts/gertrude/home.nix
                  inputs.catppuccin.homeModules.catppuccin
                ];
              };
            }
          ];
        };
      };
    };
}
