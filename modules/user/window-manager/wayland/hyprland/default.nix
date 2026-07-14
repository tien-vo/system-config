{ config, settings, inputs, ... }:
let
  inherit (settings) src arch;
  pkgs = import inputs.hyprland.inputs.nixpkgs({
    system = arch;
    overlays = [ inputs.nixgl.overlay ];
  });

  hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  hyprland-portal = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
in
{
  config.wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    package = hyprland;
    portalPackage = hyprland-portal;
  };

  config.xdg.portal = {
    enable = true;
    extraPortals = [ hyprland-portal ];
    configPackages = [ hyprland ];
  };

  imports = [
    # Crucial
    ./autostart.nix

    # Configurations
    ./config
    ./bindings.nix
    ./environment.nix
    ./monitors.nix
    ./scratchpads.nix
    ./theme.nix
    ./windowrules.nix

    # Plugins
    ./pyprland
    ./hypridle
    ./hyprpaper

    # Other dependencies
    "${src}/modules/user/services/notifications/mako"
    "${src}/modules/user/status-bar/waybar"
    "${src}/modules/user/launcher/fuzzel"
    "${src}/modules/user/services/disk/udiskie"
  ];

  config.home.shellAliases = {
    Hyprland = "${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel ${hyprland}/bin/Hyprland";
  };
}
