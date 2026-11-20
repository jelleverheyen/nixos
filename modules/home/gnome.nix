{ pkgs, ... }:
{
  home.packages = [ pkgs.gnomeExtensions.vitals ];

  dconf.settings."org/gnome/shell".enabled-extensions = [
    pkgs.gnomeExtensions.vitals.extensionUuid
  ];
}
