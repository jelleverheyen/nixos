{ pkgs, ... }:
let
  family = "IosevkaTerm Nerd Font";
in
{
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.kitty.enable = true;
  # catppuccin.alacritty.enable = true;
  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        normal = {
          inherit family;
          style = "Regular";
        };
        bold = {
          inherit family;
          style = "Bold";
        };
        italic = {
          inherit family;
          style = "Italic";
        };
        bold_italic = {
          inherit family;
          style = "Bold Italic";
        };
        size = 12;
        offset = {
          x = 1;
          y = 5;
        };
      };
    };
  };
}
