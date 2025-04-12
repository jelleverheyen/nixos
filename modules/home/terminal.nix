{ pkgs, catppuccin, ... }:
{
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.kitty.enable = true;
  catppuccin.alacritty.enable = true;
  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        normal = {
          family = "IosevkaTerm Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "IosevkaTerm Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "IosevkaTerm Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "iosevkaterm nerd font";
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
