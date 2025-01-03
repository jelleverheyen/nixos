{ pkgs, ... }:
{
  imports = [
    ./gaming.nix
    ./minecraft.nix
    ./fish.nix
  ];

  hardware.opentabletdriver.enable = true;
  nixpkgs.config.permittedInsecurePackages = [
  ];
}
