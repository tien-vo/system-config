{ pkgs, settings, ... }:
let
  inherit (settings.screen) scaling;
in
{
  config.wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1, 2256x1504@60, 0x0, ${scaling}"
  ];

  config.wayland.windowManager.hyprland.settings.xwayland = {
    force_zero_scaling = true;
  };

  config.wayland.windowManager.hyprland.settings.env = [
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_ENABLE_HIGHDPI_SCALING,1"
      "GDK_SCALE,${scaling}"
  ];

  #  config.dconf.settings = {
  #    "org/gnome/desktop/interface".scaling-factor = scaling;
  #    "org/gnome/mutter".experimental-features = "['scale-monitor-framebuffer']";
  #  };
}
