{ config, settings, ... }: 
let
  inherit (settings.window) gap border;
in
{
  # https://wiki.hyprland.org/Configuring/Variables/#general

  config.wayland.windowManager.hyprland.settings.general = {
    gaps_in = gap.inner;
    gaps_out = gap.outer;
    border_size = border.size;
    resize_on_border = true;
    hover_icon_on_border = false;
    "col.active_border" = "rgba(${border.active_color.top}ff) rgba(${border.active_color.bottom}ff) 60deg";
    "col.inactive_border" = "rgba(${border.inactive_color}ff)";
  };
}
