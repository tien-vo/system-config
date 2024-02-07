{ pkgs, ... }:
{
  config.home.packages = [
    pkgs.vifm
  ];

  config.home.file."./.config/vifm/" = {
    source = ./config;
    recursive = true;
  };
}
