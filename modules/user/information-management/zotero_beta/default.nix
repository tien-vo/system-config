{ config, pkgs, ... } @ args:
let
  inherit (builtins) toString;
  inherit (config.xdg) configHome;

  userjs = import (./userjs.nix) (args);
in
{
  config.home.packages = [
    pkgs.zotero_7
  ];

  config.xdg.dataFile."zotero/.keep".text = "";
  config.xdg.configFile."zotero/user.js".source = userjs;

  config.xdg.desktopEntries.zotero = {
    name = "Zotero";
    genericName = "Reference manager";
    exec = "zotero --profile ${configHome}/zotero";
  };
}
