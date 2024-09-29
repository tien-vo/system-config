{ pkgs, settings, ... }:
let
  inherit (settings.theme) font;
in
{
  config.programs.kitty = {
    enable = true;
    font {
      name = font.name;
      size = font.size;
    };
    shellIntegration = {
        mode = "no-cursor";
    };
    themeFile = "GruvBoxMaterialDarkMedium";
  };
}
