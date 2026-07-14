{ config, settings, ... }:
let
  inherit (settings.window) border;
in
{
  config.wayland.windowManager.hyprland.extraConfig = ''
hl.config({
    decoration = {
        rounding = ${toString(border.radius)},
        shadow = { enabled = false },
        blur = { enabled = false },
    },
})
  '';
}
