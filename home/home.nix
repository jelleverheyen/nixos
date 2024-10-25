{ pkgs, ... }:

{
  imports = [
    ./modules/dev.nix
  ];

  home.stateVersion = "24.05";

  home.username = "jelle";
  home.homeDirectory = "/home/jelle";

  home.packages = with pkgs; [
    git
    fzf
    ripgrep
    jq
    qsv
    neovim
    nerdfonts
    alacritty
    ddcutil
    spotify
    stremio
    vlc
    xclip

    # Gaming
    protonup
  ];

  home.file = {
    # For managing dotfiles
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Add installation path for ProtonGE
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
