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
  ];

  home.file = {
    # For managing dotfiles
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath = [
    "${builtins.toString ../../scripts}"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
