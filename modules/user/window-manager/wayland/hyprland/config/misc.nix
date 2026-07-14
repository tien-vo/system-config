{ config, ... }:
{
  config.wayland.windowManager.hyprland.extraConfig = ''
hl.config({
    misc = {
        force_default_wallpaper = 0,
        focus_on_activate = true,
    },
})
  '';
}
