{ pkgs, settings, ... }:
let
  inherit (builtins) toString;
  inherit (settings.theme) cursorTheme;
  inherit (settings.window) gap border;
  inherit (pkgs) writeShellScriptBin bash;
  script = writeShellScriptBin ("hyprland-set-cursor-theme") (
    ''
      hyprctl setcursor "${cursorTheme.name}" ${toString(cursorTheme.size)}
    ''
  );
in
{
  config.wayland.windowManager.hyprland.settings.exec-once = [
    "${bash}/bin/bash ${script}/bin/hyprland-set-cursor-theme"
    "gsettings set org.gnome.desktop.interface gtk-theme Gruvbox-Material-Dark"
    "gsettings set org.gnome.desktop.interface icon-theme Gruvbox-Material-Dark"
  ];
  config.wayland.windowManager.hyprland.settings.general = {
    gaps_in = gap.inner;
    gaps_out = gap.outer;
    border_size = border.size;
    resize_on_border = true;
    hover_icon_on_border = false;
    "col.active_border" = "rgba(${border.active_color.top}ff) rgba(${border.active_color.bottom}ff) 60deg";
    "col.inactive_border" = "rgba(${border.inactive_color}ff)";
  };
  config.wayland.windowManager.hyprland.settings.decoration = {
    rounding = border.radius;
    active_opacity = 1.0;
    blur.enabled = false;
    shadow.enabled = false;
  };
  config.wayland.windowManager.hyprland.settings.animations = {
    enabled = true;
    bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
    animation = [
      "windows, 1, 7, myBezier"
      "windowsOut, 1, 7, default, popin 80%"
      "border, 1, 10, default"
      "borderangle, 1, 8, default"
      "fade, 1, 7, default"
      "workspaces, 1, 6, default"
    ];
  };
}
