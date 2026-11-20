# Desktop environment layer (user side). Which DE is active is decided by
# desktop.environment in the host config (read here through osConfig).
{
  imports = [
    ./common.nix
    ./gnome.nix
    ./hyprland.nix
  ];
}
