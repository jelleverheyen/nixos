{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obs-studio
    ffmpeg
    shotcut
    vlc
    qbittorrent
  ];
}
