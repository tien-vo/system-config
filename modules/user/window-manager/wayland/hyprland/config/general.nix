{ config, settings, ... }:
let
  inherit (settings.window) gap border;
in
{
  config.wayland.windowManager.hyprland.extraConfig = ''
hl.config({
    general = {
        gaps_in = ${toString(gap.inner)},
        gaps_out = ${toString(gap.outer)},
        border_size = ${toString(border.size)},
        resize_on_border = true,
        hover_icon_on_border = false,
        col = {
            active_border = { colors = {"rgba(${border.active_color.top}ff)", "rgba(${border.active_color.bottom}ff)"}, angle =  60 },
            inactive_border = "rgba(${border.inactive_color}ff)",
        },
    },
})
  '';
}
