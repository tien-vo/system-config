{ config, settings, ... }:
let
  inherit (settings.window) gap border;
in
{
  # https://wiki.hyprland.org/Configuring/Variables/#decoration

  config.wayland.windowManager.hyprland.settings.decoration = {
    rounding = border.radius;
    blur.enabled = false;
    shadow.enabled = false;
  };
}
