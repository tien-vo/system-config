{ config, pkgs, settings, ... } @ args:
let
  inherit (builtins) toString;
  inherit (config.xdg) configHome;

  fw13 = settings.monitors.framework13;
  userjs = import (./userjs.nix) (args);
  userChrome = import (./userChrome.nix) (args);
in
{
  config.xdg.dataFile."zotero/.keep".text = "";
  config.xdg.configFile."zotero/user.js".source = userjs;
  config.xdg.configFile."zotero/chrome/userChrome.css".source = userChrome;

  config.xdg.desktopEntries.zotero = {
    name = "Zotero";
    genericName = "Reference manager";
    exec = "env GDK_DPI_SCALE=${toString(fw13.fontScaling)} zotero --profile ${configHome}/zotero";
  };

  config.home.packages = [
    pkgs.zotero
  ];
}
