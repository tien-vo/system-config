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

  # XDG compliance
  config.home.sessionVariables = {
    GOPATH = "$XDG_DATA_HOME/go";
    GOMODCACHE = "$XDG_CACHE_HOME/go/mod";
  };
}
