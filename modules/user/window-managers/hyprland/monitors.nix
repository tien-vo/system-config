{ pkgs, settings, ... }:
let
  inherit (builtins) toString;
  fw13 = settings.monitors.framework13;
  sceptre = settings.monitors.sceptre;
in
{
  config.wayland.windowManager.hyprland.settings.monitor = [
    "desc:${fw13.name}, ${fw13.resolution}, 0x0, ${toString(fw13.screenScaling)}"
    "desc:${sceptre.name}, ${sceptre.resolution}, auto, ${toString(sceptre.screenScaling)}"
  ];

  config.wayland.windowManager.hyprland.settings.xwayland = {
    force_zero_scaling = true;
  };

  config.wayland.windowManager.hyprland.settings.env = [
    #  "QT_AUTO_SCREEN_SCALE_FACTOR,1"
    #  "QT_ENABLE_HIGHDPI_SCALING,1"
    #  "GDK_SCALE,${toString(scaling)}"
  ];
}
