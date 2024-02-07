{ pkgs, settings, ... }:
let
  inherit (settings.theme) wallpaper;
  inherit (pkgs) writeShellScriptBin bash;
  script = writeShellScriptBin ("autostart") (
    ''
      function run() {
          [[ -z $(pgrep -f $1) ]] && \
              eval $* & disown || true
      }

      ${pkgs.swww}/bin/swww init
      ${pkgs.swww}/bin/swww img ${wallpaper}
      run ${pkgs.waybar}/bin/waybar
      run ${pkgs.mako}/bin/mako

      # Kludge for pyprland cause it started generating this wrapped binary
      [[ -z $(pgrep -f ${pkgs.pyprland}/bin/.pypr-wrapped) ]] && \
          ${pkgs.pyprland}/bin/pypr & disown
    ''
  );
in
{
  config.wayland.windowManager.hyprland.settings.exec = [
    "${bash}/bin/bash ${script}/bin/autostart"
  ];
}
