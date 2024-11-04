{ pkgs, ... }:

{
  home.packages = with pkgs; [
    protonup
    mangohud
    lutris
    vulkan-tools
    heroic
    dxvk

    wineWowPackages.stable
    winetricks

    #    runescape
    runelite
  ];

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
  };

}
