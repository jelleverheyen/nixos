{ pkgs, ... }:
{
  imports = [

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
    gitui
    fzf
    bat
    ripgrep
    jq
    qsv
    neovim
    ddcutil
    spotify
    stremio
    vlc
    xclip
    prismlauncher
    vesktop
    gnupg
    pinentry
    zathura
  ];
}
