{ config, pkgs, settings, ... }:
let
  inherit (config.xdg) dataHome;
  inherit (config.home) homeDirectory;
  inherit (settings.theme) font;
in
pkgs.writeTextFile ({
  name = "user.js";
  text = ''
    user_pref("extensions.zotero.dataDir", "${dataHome}/zotero");
    user_pref("extensions.zotero.export.quickCopy.setting", "export=ca65189f-8815-4afe-8c8b-8c7c15f0edca");
    user_pref("extensions.zotero.translators.better-bibtex.citekeyFormat", "auth.lower + year + infix");
    user_pref("extensions.zotero.translators.better-bibtex.citekeyFormatEditing", "auth.lower + year + infix");
    user_pref("extensions.zotero.translators.better-bibtex.platform", "lin");
    user_pref("extensions.zotero.secondarySort.title", "year");

    user_pref("extensions.zotfile.dest_dir", "${homeDirectory}/Sync/zotero");
    user_pref("extensions.zotfile.import", false);
    user_pref("extensions.zotfile.max_authors", 1);
    user_pref("extensions.zotfile.add_etal", false);
    user_pref("extensions.zotfile.source_dir", "${dataHome}/zotero");
    user_pref("extensions.zotfile.source_dir_ff", false);
    user_pref("extensions.zotfile.subfolder", true);
    user_pref("extensions.zotfile.subfolderFormat", "/%a");

    user_pref("extensions.zutilo.itemmenu.modifyAttachments", "Zutilo");
    user_pref("extensions.zutilo.itemmenu.showAttachments", "Zutilo");

    user_pref("extensions.zotero.sortCreatorAsString", true);
    user_pref("extensions.zotero.secondarySort.title", "year");
    user_pref("extensions.zotero.secondarySort.firstCreator", "year");

    user_pref("font.default.x-western", "${font.name}");
  '';
})
