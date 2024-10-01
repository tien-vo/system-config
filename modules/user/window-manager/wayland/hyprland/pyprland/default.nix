{ config, pkgs, ... }:
{
  config.home.packages = [ pkgs.pyprland ];
  config.xdg.configFile."hypr/pyprland.toml".source = ./pyprland.toml;
}
