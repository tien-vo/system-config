{ settings, ... }:
let
  inherit (settings) src;
in
{
  imports = [
    ./config

    "${src}/modules/user/window-manager/status-bar/waybar"
    "${src}/modules/user/window-manager/launcher/fuzzel"
  ];
}
