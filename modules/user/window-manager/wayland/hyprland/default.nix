{ settings, ... }:
let
  inherit (settings) src;
in
{
  imports = [
    ./config

    "${src}/modules/user/window-manager/wayland/hypridle"
    "${src}/modules/user/window-manager/wayland/hyprpaper"

    "${src}/modules/user/daemon/mako"
    "${src}/modules/user/window-manager/status-bar/waybar"
    "${src}/modules/user/window-manager/launcher/fuzzel"
  ];
}
