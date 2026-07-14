{ config, pkgs, ... }:
{
  config.wayland.windowManager.hyprland.extraConfig = ''
---- Hyprland
-- More verbose logging
hl.env("HYPRLAND_TRACE", "1")

-- Disable sd_notify in favor of systemd
hl.env("HYPRLAND_NO_SD_NOTIFY", "1")

---- Aquamarine
-- More verbose logging
hl.env("AQ_TRACE", "1")

-- Disable modifier to prevent crashes
hl.env("AQ_NO_MODIFIERS", "1")

---- Backends
-- Libseat
hl.env("LIBSEAT_BACKEND", "logind")

-- GTK: Try wayland, then X11, then fall back to any other backend
hl.env("GDK_BACKEND", "wayland,x11,*")

-- QT: Try wayland, then fall back to X11
hl.env("QT_QPA_PLATFORM", "wayland;xcb")

-- QT: Disable decoration
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- QT: Automatic scaling
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

-- Clutter: Use wayland
hl.env("CLUTTER_BACKEND", "wayland")

-- Nixos: Hint Electron apps to use wayland
hl.env("NIXOS_OZONE_WL", "1")

-- Firefox: Use wayland
hl.env("MOZ_ENABLE_WAYLAND", "1")

---- Xdg
-- Set Hyprland as current desktop
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")

-- Set Hyprland as session desktop
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Set wayland as session type
hl.env("XDG_SESSION_TYPE", "wayland")
  '';
}
