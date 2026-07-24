{ config, pkgs, settings, inputs, ... }:
{
  config.xdg = {
    enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };

  # XDG compliance
  config.home.sessionVariables = {
    GOPATH = "${config.xdg.dataHome}/go";
    GOMODCACHE = "${config.xdg.cacheHome}/go/mod";
  };
}
