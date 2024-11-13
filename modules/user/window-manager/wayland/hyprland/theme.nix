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
}
