{ pkgs, ... }:
{
  config.home.packages = [
    pkgs.openconnect
    pkgs.networkmanager-openconnect
  ];
}
