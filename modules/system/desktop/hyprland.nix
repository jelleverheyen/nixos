# Hyprland (active when desktop.environment = "hyprland").
{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.desktop.environment == "hyprland") {
    programs.uwsm.enable = true;

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      systemd.setPath.enable = true;
    };

    # Greeter (replaces GDM)
    programs.regreet.enable = true;

    # See: https://wiki.hyprland.org/Hypr-Ecosystem/xdg-desktop-portal-hyprland/
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    programs.hyprlock.enable = true;

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}
