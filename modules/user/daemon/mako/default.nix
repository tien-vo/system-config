{ settings, ... }:
let
  inherit (builtins) ceil toString;
  inherit (settings.theme.colorScheme) palette;
  inherit (settings.theme) font;
  inherit (settings.window) border;

  PT_TO_PX = 1.334;
  borderRadius = ceil(PT_TO_PX * border.radius);
  borderSize = ceil(PT_TO_PX * border.size);
  fontSize = ceil(PT_TO_PX * font.size);
in
{
  config.services.mako = {
    enable = true;
    height = 300;
    width = 400;
    margin = "20,20";
    defaultTimeout = 5000;
    backgroundColor = "#${palette.base00}";
    borderColor = border.active_color.top;
    font = "${font.name} ${toString(fontSize)}";
    inherit borderRadius borderSize;
  };
}
