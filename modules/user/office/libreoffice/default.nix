{ pkgs, ... }:
{
  config.home.packages = [
    pkgs.libreoffice-qt-fresh
  ];
}
