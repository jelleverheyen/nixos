{
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/home/default.nix
  ];

  home.stateVersion = "24.05";

  home.username = "jelle";
  home.homeDirectory = "/home/jelle";

  home.packages = with pkgs; [
    git
    fzf
    bat
    ripgrep
    jq
    qsv
    neovim
    nerdfonts
    ddcutil
    spotify
    stremio
    vlc
    xclip
    prismlauncher
    vesktop
    gnupg
    pinentry
  ];

  home.file = {
    # For managing dotfiles
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
