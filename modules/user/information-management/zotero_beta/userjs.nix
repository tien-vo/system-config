{ config, pkgs, ... }:
let
  inherit (config.xdg) dataHome;
in
pkgs.writeTextFile ({
  name = "user.js";
  text = ''
    user_pref("extensions.zotero.dataDir", "${dataHome}/zotero");
    user_pref("extensions.zotero.recursiveCollections", false);
    user_pref("extensions.zotero.automaticSnapshots", false);
    user_pref("extensions.zotero.automaticTags", false);
    user_pref("extensions.zotero.purge.tags", true);
    user_pref("extensions.zotero.sortCreatorAsString", true);
    user_pref("extensions.zotero.secondarySort.title", "year");
    user_pref("extensions.zotero.secondarySort.firstCreator", "year");
  '';
})
