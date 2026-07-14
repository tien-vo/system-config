{ config, ... }:
{
  config.wayland.windowManager.hyprland.extraConfig = ''
hl.config({
    input = {
        repeat_rate = 30,
        repeat_delay = 300,
        sensitivity = 0.0,
        follow_mouse = 2,
        mouse_refocus = true,
        float_switch_override_focus = false,
        touchpad = {
            tap_button_map = "lrm",
            natural_scroll = false,
            scroll_factor = 0.5,
        },
    },

    cursor = {
        no_warps = true,
    },
})
  '';
}
