# Desktop environment layer, selected by desktop.environment.
#
#   common.nix   - session settings shared by every DE
#   gnome.nix    - GDM + GNOME
#   hyprland.nix - Hyprland + greetd
#
# modules/home/desktop reads the same option.
{ lib, ... }:
{
  imports = [
    ./common.nix
    ./gnome.nix
    ./hyprland.nix
  ];

  options.desktop.environment = lib.mkOption {
    type = lib.types.enum [
      "gnome"
      "hyprland"
    ];
    default = "gnome";
    description = "Which desktop environment is active.";
  };
}
