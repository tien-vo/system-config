{ config, ... }:
{
  config.wayland.windowManager.hyprland.extraConfig = ''
hl.config({
    ecosystem = {
        no_update_news = true,
    },
})
  '';
}
