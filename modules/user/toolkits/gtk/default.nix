{ config, pkgs, settings, ... }:
{
  config.gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
    inherit (settings.theme) theme font iconTheme cursorTheme;
  };
}
