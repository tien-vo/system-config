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

      run ${pkgs.hyprpaper}/bin/hyprpaper
      run ${pkgs.waybar}/bin/waybar
      run ${pkgs.filen-desktop}/bin/filen-desktop

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
