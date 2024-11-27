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
      set -g prefix C-s
      set -g mouse on

      setw -g mode-keys vi
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
    '';
  };
}
