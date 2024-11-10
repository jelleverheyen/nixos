{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    historyLimit = 25000;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catpuccin_flavour 'mocha'
          set -g @catpuccin_window_tabs_enabled on
          set -g @catpuccin_date_time "%H:%M"
        '';
      }
    ];

    extraConfig = ''

    '';
  };
}
