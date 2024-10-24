{ pkgs, ... }:
 
{
  hardware.graphics.enable = true;

  programs.gamemode.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    lutris
    heroic

    wineWowPackages.stable
    winetricks
  ];

  services.xserver.videoDrivers = ["amdgpu"];
}
