{ pkgs, ... }:
{
  config.home.packages = [
    pkgs.micromamba
  ];
}
