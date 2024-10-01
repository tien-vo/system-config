{ ... }:
{
  config.wayland.windowManager.hyprland.settings.env = [
    # See documentation at https://wiki.hyprland.org/Configuring/Environment-variables)

    "HYPRLAND_LOG_WLR,1"                        # Hyprland: More verbose wlroots logging
    "HYPRLAND_NO_SD_NOTIFY,1"                   # Hyprland: Disable sd_notify in favor of systemd

    "LIBSEAT_BACKEND,logind"

    "AQ_NO_MODIFIERS,1"                         # Aquamarine: Disable modifier to prevent crashes

    "GDK_BACKEND,wayland,x11,*"                 # GTK: Try wayland, then X11, then fall back to any other backend

    "QT_QPA_PLATFORM,wayland;xcb"               # QT: Try wayland, then fall back to X11
    "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"     # QT: Disable decoration
    "QT_AUTO_SCREEN_SCALE_FACTOR,1"             # QT: Automatic scaling

    "CLUTTER_BACKEND,wayland"                   # Clutter: Use wayland

    "XDG_CURRENT_DESKTOP,Hyprland"              # Xdg: Set Hyprland as current desktop
    "XDG_SESSION_DESKTOP,Hyprland"              # Xdg: Set Hyprland as session desktop
    "XDG_SESSION_TYPE,wayland"                  # Xdg: Set wayland as session type

    "NIXOS_OZONE_WL,1"                          # Nixos: Hint Electron apps to use wayland

    "MOZ_ENABLE_WAYLAND,1"                      # Tell Firefox to use wayland
  ];
}
