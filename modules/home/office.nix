{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libreoffice
    calibre
    qalculate-gtk
    qpdf
  ];
}
