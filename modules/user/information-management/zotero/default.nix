{ config, pkgs, ... } @ args:
let
  inherit (builtins) toString;
  inherit (config.xdg) stateHome;

  userjs = import (./userjs.nix) (args);
in
{
  config.xdg.stateFile."zotero/user.js".source = userjs;

  config.xdg.desktopEntries.zotero = {
    name = "Zotero";
    genericName = "Reference manager";
    exec = ''sh -c "${pkgs.zotero}/bin/zotero --profile ${stateHome}/zotero" %u'';
    icon = "zotero";
    type = "Application";
  };
}
