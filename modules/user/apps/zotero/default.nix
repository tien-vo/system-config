{ config, pkgs, settings, ... } @ args:
let
  inherit (settings.screen) scaling;

  userjs = import(./userjs.nix)(args);
  userChrome = import(./userChrome.nix)(args);
in
{
  config.xdg.dataFile."zotero/.keep".text = "";
  config.xdg.configFile."zotero/user.js".source = userjs;
  config.xdg.configFile."zotero/chrome/userChrome.css".source = userChrome;

  config.xdg.desktopEntries.zotero = {
    name = "Zotero";
    genericName = "Reference manager";
    exec = "env GDK_DPI_SCALE=${scaling} zotero --profile ${config.xdg.configHome}/zotero";
  };

  config.home.packages = [
    pkgs.zotero
  ];
}
