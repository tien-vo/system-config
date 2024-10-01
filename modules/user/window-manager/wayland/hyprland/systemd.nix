{ ... }:
{
  config.wayland.windowManager.hyprland.systemd = {
    enable = true;
    enableXdgAutostart = true;
    variables = [
      "WAYLAND_DISPLAY"
      "XDG_CURRENT_DESKTOP"
      "--all"
    ];
    extraCommands = [
      "systemctl --user stop hyprland-session.target"
      "systemctl --user start hyprland-session.target"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORMTHEME"

      "systemctl --user enable dconf.service"  # For gtk to work properly
    ];
  };
}
