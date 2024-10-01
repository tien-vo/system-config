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

      run "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
      run ${pkgs.hyprpaper}/bin/hyprpaper
      run ${pkgs.waybar}/bin/waybar
      run ${pkgs.mako}/bin/mako
      run ${pkgs.networkmanagerapplet}/bin/nm-applet
      run ${pkgs.blueman}/bin/blueman-applet
      run ${pkgs.udiskie}/bin/udiskie --smart-tray

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
