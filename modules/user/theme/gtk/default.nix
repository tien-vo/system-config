{ config, pkgs, settings, ... }:
let
  inherit (settings.theme) font cursorTheme;
in {
  config.home.packages = [
    pkgs.dconf
  ];
  config.gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
    #  inherit (settings.theme) font cursorTheme;
  };
}
