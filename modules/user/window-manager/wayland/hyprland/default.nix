{ config, settings, inputs, ... }:
let
  inherit (settings) src arch;
  hyprland = inputs.hyprland.packages.${arch}.hyprland;
  hyprland-portal = inputs.hyprland.packages.${arch}.xdg-desktop-portal-hyprland;
in
{
  config.wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = hyprland;
  };

  config.xdg.portal = {
    enable = true;
    extraPortals = [ hyprland-portal ];
    configPackages = [ hyprland ];
  };

  imports = [
    # Crucial
    ./systemd.nix

    # Configs
    ./autostart.nix
    ./environment.nix
    ./keybindings.nix
    ./scratchpads.nix
    ./windowrules.nix
    ./monitors.nix
    ./cursor.nix
    ./input.nix
    ./theme.nix
    ./misc.nix

    # Plugins
    ./pyprland
    ./hypridle
    ./hyprpaper

    # Other dependencies
    "${src}/modules/user/services/notifications/mako"
    "${src}/modules/user/status-bar/waybar"
    "${src}/modules/user/launcher/fuzzel"
  ];
}
