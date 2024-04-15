{ pkgs, ... }:
{
  config.home.packages = [
    pkgs.ibus-engines.bamboo
  ];
}
