{ config, pkgs, ... }:
{
  config.wayland.windowManager.hyprland.settings.bind = [
    "SUPER, SPACE, exec, ${pkgs.pyprland}/bin/pypr toggle term"
    "SUPER, V, exec, ${pkgs.pyprland}/bin/pypr toggle vifm"
  ];

  config.wayland.windowManager.hyprland.settings.windowrule = [
    "float on, match:class (kitty-dropterm)(.*)"
    "float on, match:class (fm-dropterm)(.*)"
    "workspace special:scratchpad silent, match:class (vifm-dropterm)(.*)"
  ];
}
