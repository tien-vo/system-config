{ config, ... }: 
{
  # https://wiki.hyprland.org/Configuring/Variables/#ecosystem
  config.wayland.windowManager.hyprland.settings.ecosystem = {
    no_update_news = true;
  };
}
