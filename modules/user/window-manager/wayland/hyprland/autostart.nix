{ pkgs, settings, ... }:
let
  inherit (settings.theme) wallpaper;
  inherit (pkgs) writeShellScriptBin bash;
  script = writeShellScriptBin ("autostart") (
    ''
      function run() {
          [[ -z $(pgrep -f "$1") ]] && "$@" &
      }

      run ${pkgs.hyprpaper}/bin/hyprpaper
      run ${pkgs.waybar}/bin/waybar
      run ${pkgs.filen-desktop}/bin/filen-desktop
      run ${pkgs.pyprland}/bin/pypr
    ''
  );
in
{
  config.home.packages = [
    pkgs.hyprpolkitagent
  ];

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

      "systemctl --user enable dconf.service"    # For gtk to work properly
      "systemctl --user enable udiskie.service"  # For gtk to work properly

      "systemctl --user enable hyprpolkitagent.service"
    ];
  };

  config.wayland.windowManager.hyprland.extraConfig = ''
hl.on("hyprland.start", function ()
    hl.exec_cmd("${script}/bin/autostart")
    hl.exec_cmd("systemctl --user start restic-login-notification.service")
end)
  '';
}
