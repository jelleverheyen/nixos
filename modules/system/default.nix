{ pkgs, ... }:
{
  imports = [
    ./gaming.nix
    ./minecraft.nix
    ./fish.nix
    ./ai.nix
  ];

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.iosevka-term
      liberation_ttf
      noto-fonts
      noto-fonts-emoji
      # CJK
      noto-fonts-cjk-sans
      wqy_microhei
      wqy_zenhei

      # Persian fonts
      vazir-fonts
    ];

    fontconfig = {
      defaultFonts = {
        serif = [
          "Noto Serif"
          "Liberation Serif"
          "Vazirmatn"
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Sans CJK SC"
          "Liberation Sans"
          "Vazirmatn"
          "Noto Color Emoji"
        ];
        monospace = [
          "Iosevka Term Nerd Font"
          "Noto Sans Mono CJK SC"
          "Liberation Mono"
        ];
        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };

  hardware.opentabletdriver.enable = true;
  nixpkgs.config.permittedInsecurePackages = [
  ];
}
