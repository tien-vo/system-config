{ config, pkgs, inputs, settings, ... } @ args:
let
  inherit (settings) arch;
  hyprland = inputs.hyprland.packages.${arch}.hyprland;
  hyprland-portal = inputs.hyprland.packages.${arch}.xdg-desktop-portal-hyprland;
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
    package = hyprland;
    xwayland.enable = true;
    systemd = {
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

        "systemctl --user enable dconf.service"                   # For gtk
      ];
    };
  };
  config.xdg.portal = {
    enable = true;
    extraPortals = [ hyprland-portal ];
    configPackages = [ hyprland ];
  };
  config.home.packages = [
    pkgs.hyprpicker
    pkgs.pyprland
  ];
  config.xdg.configFile."hypr/pyprland.toml".source = ./pyprland.toml;
}
