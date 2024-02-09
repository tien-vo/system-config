{ pkgs, ... }:
{
  config.home.packages = [
    pkgs.cryptomator
  ];
}
