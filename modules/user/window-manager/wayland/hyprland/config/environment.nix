{ ... }:
{
  config.wayland.windowManager.hyprland.settings.env = [
    # Hyprland
    "HYPRLAND_LOG_WLR,1" # More verbose wlroots logging
    "HYPRLAND_NO_SD_NOTIFY,1" # Disable sd_notify in favor of systemd

    # Toolkit backend
    "GDK_BACKEND,wayland,x11" # GTK: Try wayland, otherwise fallback to X11
    "QT_QPA_PLATFORM,wayland;xcb" # QT: Same
    "CLUTTER_BACKEND,wayland" # Clutter: Same

    # XDG specifications
    "XDG_CURRENT_DESKTOP,Hyprland"
    "XDG_SESSION_TYPE,wayland"
    "XDG_SESSION_DESKTOP,Hyprland"

    # Nix
    "NIXOS_OZONE_WL,1" # Hint Electron apps to use wayland

    # Misc
    "MOZ_ENABLE_WAYLAND,1" # Tell Firefox to use wayland
    # "WLR_NO_HARDWARE_CURSORS,1"
  ];
}
