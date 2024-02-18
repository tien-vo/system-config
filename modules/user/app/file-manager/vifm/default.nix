{ pkgs, ... }:
{
  config.home.packages = [
    pkgs.vifm
    pkgs.evince
  ];

  config.home.file."./.config/vifm/" = {
    source = ./config;
    recursive = true;
  };
}
