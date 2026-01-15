{ pkgs, ... }:

{
  home.packages = with pkgs; [
    protonup-ng
    mangohud
    lutris
    vulkan-tools
    heroic
    dxvk

    wineWowPackages.stable
    winetricks

    # runescape
    bolt-launcher
    runelite

    # OOT
    shipwright
    _2ship2harkinian

    cdemu-daemon
    gcdemu

  ];

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
  };

}
