{ pkgs, ... }:
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
    pkgs.pyprland
  ];
  config.home.file."./.config/hypr/pyprland.toml".source = ./pyprland.toml;
}
