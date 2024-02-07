{ config, pkgs, ... }:
{
  #  config.xdg.configFile."zotero/user.js".source = ./user.js;
  config.xdg.dataFile."zotero/.keep".text = "";
  config.home.file."./.config/zotero/" = {
    source = ./config;
    recursive = true;
  };

  config.xdg.desktopEntries.zotero = {
    name = "Zotero";
    genericName = "Reference manager";
    exec = "zotero --profile ${config.xdg.configHome}/zotero";
  };

  config.home.packages = [
    pkgs.zotero
  ];
}
