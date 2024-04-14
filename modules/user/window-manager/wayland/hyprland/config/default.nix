{ pkgs, ... } @ args:
let
  hyprpaperConfig = import (./hyprpaper.nix) (args);
in
{
  imports = [
    ./autostart.nix
    ./environment.nix
    ./keybindings.nix
    ./scratchpads.nix
    ./windowrules.nix
    ./monitors.nix
    ./input.nix
    ./theme.nix
    ./misc.nix
  ];
  config.wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
  };
  config.home.packages = [
    pkgs.hyprpicker
    pkgs.hyprpaper
    pkgs.pyprland
  ];
  config.xdg.configFile."hypr/pyprland.toml".source = ./pyprland.toml;
  config.xdg.configFile."hypr/hyprpaper.conf".source = hyprpaperConfig;
}
