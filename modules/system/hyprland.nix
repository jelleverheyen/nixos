{ inputs, pkgs, ... }:
{
  # programs.uwsm = {
  #   enable = true;
  # };

  # programs.regreet = {
  #   enable = true;
  # };

  # programs.hyprland = {
  #   enable = true;
  #   withUWSM = true;
  #   xwayland.enable = true;
  #   systemd.setPath.enable = true;
  # };

  # # See: https://wiki.hyprland.org/Hypr-Ecosystem/xdg-desktop-portal-hyprland/
  # xdg.portal.extraPortals = [
  #   pkgs.xdg-desktop-portal-gtk
  # ];

  # programs.hyprlock = {
  # enable = true;
  # };

  services.displayManager.autoLogin = {
    enable = true;
    user = "jelle";
  };

  # services.gnome.gnome-keyring.enable = true;
  # security.pam.services.greetd.enableGnomeKeyring = true;

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  services.xserver = {
    enable = true;

    xkb.layout = "us";
    xkb.variant = "";
  };
}
