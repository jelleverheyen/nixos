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

    # runescape
    runelite

    # OOT
    shipwright
    _2ship2harkinian

  ];

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
  };

}
