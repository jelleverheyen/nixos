{ pkgs, ... }:
{
  imports = [
    ./gaming.nix
    ./minecraft.nix
    ./fish.nix
    ./ai.nix
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    nerd-fonts.iosevka-term
  ];
  hardware.opentabletdriver.enable = true;
  nixpkgs.config.permittedInsecurePackages = [
  ];
}
