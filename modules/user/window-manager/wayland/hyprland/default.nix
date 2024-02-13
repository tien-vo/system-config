{ settings, ... }:
let
  inherit (settings) src;
in
{
  imports = [
    ./config

    "${src}/modules/user/daemon/mako"
    "${src}/modules/user/daemon/swww"
    "${src}/modules/user/window-manager/status-bar/waybar"
    "${src}/modules/user/window-manager/launcher/fuzzel"
  ];
}
