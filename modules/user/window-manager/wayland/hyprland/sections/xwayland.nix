{ config, ... }:
{
  # Not sure about the difference between
  #  https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.xwayland.enable
  #  and simply adding it via
  #  https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.settings
  config.wayland.windowManager.hyprland.xwayland = {
    enable = true;
  };
}
