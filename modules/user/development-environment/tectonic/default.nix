{ pkgs, ... }:
{
  config.home.packages = [
    pkgs.tectonic
    pkgs.entr
  ];
}
