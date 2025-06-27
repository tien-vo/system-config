{ config, pkgs, ... }:
{
  config.wayland.windowManager.hyprland.settings.bind = [
    "SUPER, SPACE, exec, ${pkgs.pyprland}/bin/pypr toggle term"
    "SUPER, V, exec, ${pkgs.pyprland}/bin/pypr toggle vifm"
  ];

  config.wayland.windowManager.hyprland.settings.windowrulev2 = [
    "float, class:^(kitty-dropterm)(.*)$"
    "float, class:^(fm-dropterm)(.*)$"
    "workspace special:scratchpad silent, class:^(vifm-dropterm)(.*)$"
  ];
}
