{ pkgs, settings, ... }:
let
  inherit (settings.theme) wallpaper;
in
pkgs.writeTextFile ({
  name = "hyprpaper.conf";
  text = ''
  preload = ${wallpaper}
  wallpaper = ,${wallpaper}
  '';
})
