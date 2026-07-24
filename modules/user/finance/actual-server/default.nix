{ pkgs, ... }:
{
  config.home.packages = [
    pkgs.actual-server
  ];
}
