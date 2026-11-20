# Hyprland (active when desktop.environment = "hyprland").
{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  terminal = "alacritty";
  fileManager = "nautilus";
  menu = "onagre";
in
{
  config = lib.mkIf (osConfig.desktop.environment == "hyprland") {
    home.packages = with pkgs; [
      onagre
      grimblast
      nautilus
      playerctl
    ];

    services.dunst.enable = true;

    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        wallpaper = [
          {
            monitor = "";
            path = "${pkgs.nixos-artwork.wallpapers.simple-dark-gray}/share/backgrounds/nixos/nix-wallpaper-simple-dark-gray.png";
          }
        ];
      };
    };

    programs.hyprlock = {
      enable = true;
      settings = {
        background = [ { color = "rgb(1a1a1a)"; } ];
        input-field = [
          {
            size = "250, 50";
            position = "0, -80";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = [
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 600;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };

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

        # ASUS 1080p@60 on the left, AOC 1440p@144 on the right
        monitor = [
          "HDMI-A-1,1920x1080@60,0x235,1"
          "DP-3,2560x1440@144,1920x0,1"
        ];

        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];

        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 10;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;
          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];
          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
          ];
        };

        device = {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        };

        bind = [
          "$mod, Q, exec, ${terminal}"
          "$mod, C, killactive,"
          "$mod, M, exit,"
          "$mod, E, exec, ${fileManager}"
          "$mod, V, togglefloating,"
          "$mod, R, exec, ${menu}"
          "$mod, P, pseudo,"
          "$mod, J, togglesplit,"
          "$mod, Escape, exec, hyprlock"
          ", Print, exec, grimblast copy area"

          # focus
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          # scroll through workspaces
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          # workspace 10
          "$mod, code:19, workspace, 10"
          "$mod SHIFT, code:19, movetoworkspace, 10"
        ]
        ++ (
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

        # SUPER + left/right mouse drag moves/resizes windows
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        # volume (repeat while held)
        bindel = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];

        # media keys (work while locked)
        bindl = [
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];
      };
    };
  };
}
