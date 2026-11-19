{ pkgs, ... }:
{
  home.packages = [ pkgs.nix-your-shell ];

  # Snippets go in conf.d rather than programs.fish so they don't collide with
  # the existing hand-written ~/.config/fish/config.fish.
  xdg.configFile."fish/conf.d/nix-your-shell.fish".text = ''
    # Keep fish (instead of bash) inside `nix-shell` / `nix develop`
    if status is-interactive
      nix-your-shell fish | source
    end
  '';

  xdg.configFile."fish/conf.d/tmux-autostart.fish".text = ''
    # Start every interactive terminal inside a fresh tmux session
    if status is-interactive; and not set -q TMUX; and command -sq tmux
      exec tmux
    end
  '';
}
