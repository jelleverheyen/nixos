# GNOME (active when desktop.environment = "gnome").
{ config, lib, ... }:
{
  config = lib.mkIf (config.desktop.environment == "gnome") {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
  };
}
