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
    settings = {
      margin = "20,20";
      height = 300;
      width = 400;
      font = "${font.name} ${toString(font.size)}";
      default-timeout = 5000;
      border-size = border.size;
      border-radius = border.radius;
      border-color = "#${border.active_color.bottom}";
      background-color = "#${palette.base00}";
      progress-color = "over #${palette.base0A}";
    };
  };

  config.home.packages = [
    pkgs.libnotify
  ];
}
