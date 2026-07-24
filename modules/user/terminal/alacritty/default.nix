{ pkgs, settings, ... }:
let
  inherit (settings.theme) font;
in
{
  config.programs.alacritty = {
    enable = true;
    settings = {
      live_config_reload = true;
      env.TERM = "alacritty";
      window = {
        class.general = "Alacritty";
        class.instance = "Alacritty";
        title = "Alacritty";
        decorations = "none";
        decorations_theme_variant = "Dark";
        dynamic_padding = false;
        opacity = 0.8;
      };
      cursor.style.shape = "Block";
      font = {
        normal.family = font.name;
        size = font.size;
      };
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
    };
  };
}
