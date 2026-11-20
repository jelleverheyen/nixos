# GNOME (active when desktop.environment = "gnome").
{ pkgs, lib, osConfig, ... }:
{
  config = lib.mkIf (osConfig.desktop.environment == "gnome") {
    home.packages = [ pkgs.gnomeExtensions.vitals ];

    dconf.settings."org/gnome/shell".enabled-extensions = [
      pkgs.gnomeExtensions.vitals.extensionUuid
    ];
  };
}
