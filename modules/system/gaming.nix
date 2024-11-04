{ pkgs, ... }:
{
  hardware.graphics.enable = true;

  programs.gamemode.enable = true;

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];
}
