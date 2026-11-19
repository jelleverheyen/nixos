{ pkgs, ... }:

{
  home.packages = with pkgs; [
    protonup-ng
    mangohud
    lutris
    vulkan-tools
    dxvk

    wineWow64Packages.stable
    winetricks

    # runescape
    bolt-launcher

    # OOT
    shipwright
    _2ship2harkinian

  ];

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
  };

}
