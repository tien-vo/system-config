{ pkgs, ... }:
{
  config.home.packages = [
    pkgs.xfce.thunar
  ];
}
