{ ... }:
{
  config.wayland.windowManager.hyprland.settings.bind = [
    "SUPER, SPACE, exec, pypr toggle term"
    "SUPER, V, exec, pypr toggle vifm"
  ];

  config.wayland.windowManager.hyprland.settings.windowrulev2 = [
    "float, class:^(vifm-dropterm)(.*)$"
    "workspace special:scratchpad silent, class:^(vifm-dropterm)(.*)$"
  ];
}
