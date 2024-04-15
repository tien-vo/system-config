{ pkgs, ... }:
{
  config.home.packages = [
    pkgs.ibus
    pkgs.ibus-engines.bamboo
  ];
}
