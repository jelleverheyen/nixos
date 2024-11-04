{ inputs, pkgs, ... }:
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers = {
      best-buds = {
        enable = true;
        openFirewall = true;
        package = pkgs.vanillaServers.vanilla-1_21_3;

        serverProperties = {
          gamemode = 0; # Survival
          difficulty = "hard";
          spawn_monsters = "true";
          pvp = "true";
          view-distance = "15";
          #          white-list = true;
          #          whitelist = {
          #            omejelle = "134ee3e0-807a-4646-83f7-7fc2c0e4de11";
          #            klapperlifestyle = "3fd9c8b7-255b-4c16-a32f-0ce0d00c497d";
          #            uvularmanatee = "05332c7e-4296-43df-8221-b651c8f74578";
          #          };
        };
      };
    };
  };
}
