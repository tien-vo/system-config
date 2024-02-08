{ pkgs, ... }:
{
  config.home.packages = [
    pkgs.micromamba
  ];

  config.xdg.configFile."mamba/mambarc".source = ./mambarc;
}
