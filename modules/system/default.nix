{ pkgs, ... }:
{
  imports = [
    ./gaming.nix
    ./minecraft.nix
    ./fish.nix
    ./ai.nix
  ];

  hardware.opentabletdriver.enable = true;
  nixpkgs.config.permittedInsecurePackages = [
  ];
}
