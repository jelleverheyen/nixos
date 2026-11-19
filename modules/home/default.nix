{ pkgs, ... }:
{
  imports = [
    ./lang.nix
    ./gaming.nix
    ./dev.nix
    ./creative.nix
    ./av.nix
    ./office.nix
    ./3d.nix

    ./terminal.nix
    ./tmux.nix
    ./hyprland.nix
  ];

  home.packages = with pkgs; [
    killall
    pandoc
    glow
    git
    fzf
    bat
    ripgrep
    jq
    qsv
    neovim
    ddcutil
    tidal-hifi
    stremio-linux-shell
    xclip
    gnupg # ~/.gitconfig points gpg.program at the per-user profile
    prismlauncher
    vesktop
    zathura
    numbat
  ];
}
