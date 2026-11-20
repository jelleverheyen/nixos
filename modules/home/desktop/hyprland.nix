# Hyprland (active when desktop.environment = "hyprland").
{ pkgs, lib, osConfig, ... }:
{
  config = lib.mkIf (osConfig.desktop.environment == "hyprland") {
    home.packages = with pkgs; [
      onagre
      grimblast
    ];

    services.dunst.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      # Package and portal come from the NixOS module (programs.hyprland)
      package = null;
      portalPackage = null;
      # UWSM manages the session, so skip the HM systemd integration
      systemd.enable = false;
      configType = "hyprlang";

      settings = {
        "$mod" = "SUPER";
        bind = [
          "$mod, F, exec, firefox"
          "$mod, R, exec, onagre"
          ", Print, exec, grimblast copy area"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = i + 1;
              in
              [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            ) 9
          )
        );
      };
    };
  };
}
