{ settings, ... }:
let
  inherit (settings.theme) wallpaper;
in
{
  config.services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;
      preload = "${wallpaper}";
      wallpaper = ",${wallpaper}";
    };
  };
}
