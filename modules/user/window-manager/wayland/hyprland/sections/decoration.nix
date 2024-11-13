{ config, settings, ... }:
let
  inherit (settings.window) gap border;
in
{
  # https://wiki.hyprland.org/Configuring/Variables/#decoration

  config.wayland.windowManager.hyprland.settings.decoration = {
    rounding = border.radius;
    active_opacity = 1.0;
    blur.enabled = false;
    shadow.enabled = false;
  };
}
