{ pkgs, settings, ... }:
let
  inherit (builtins) ceil toString;
  inherit (settings.theme.colorScheme) palette;
  inherit (settings.theme) font;
  inherit (settings.window) border;
in
{
  config.services.mako = {
    enable = true;
    height = 300;
    width = 400;
    margin = "20,20";
    defaultTimeout = 5000;
    font = "${font.name} ${toString(font.size)}";
    borderSize = border.size;
    borderRadius = border.radius;
    borderColor = "#${border.active_color.bottom}";
    backgroundColor = "#${palette.base00}";
  };

  config.home.packages = [
    pkgs.libnotify
  ];
}
