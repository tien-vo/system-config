{ pkgs, ... }:
{
  config.xdg = {
    enable = true;
    portal = {
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
