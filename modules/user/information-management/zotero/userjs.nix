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
    user_pref("extensions.zotero.secondarySort.title", "year");
    user_pref("extensions.zotero.recursiveCollections", false);
    user_pref("extensions.zotero.automaticSnapshots", false);
    user_pref("extensions.zotero.automaticTags", false);
    user_pref("extensions.zotero.purge.tags", true);

    user_pref("extensions.zotero.translators.better-bibtex.citekeyFold", false);
    user_pref("extensions.zotero.translators.better-bibtex.citekeyFormat", "auth.lower + (authini.len(\">\", 1) ? \"+\" : \"\") + year + infix(start=1)");
    user_pref("extensions.zotero.translators.better-bibtex.citekeyFormatEditing", "auth.lower + (authini.len(\">\", 1) ? \"+\" : \"\") + year + infix(start=1)");

    user_pref("extensions.zotfile.dest_dir", "${homeDirectory}/workspace/library/assets/zotero");
    user_pref("extensions.zotfile.import", false);
    user_pref("extensions.zotfile.max_authors", 1);
    user_pref("extensions.zotfile.add_etal", false);
    user_pref("extensions.zotfile.source_dir", "${dataHome}/zotero");
    user_pref("extensions.zotfile.source_dir_ff", false);
    user_pref("extensions.zotfile.subfolder", true);
    user_pref("extensions.zotfile.subfolderFormat", "/%a");
    user_pref("extensions.zotfile.max_titlelength", 500);
    user_pref("extensions.zotfile.replace_blanks", true);
    user_pref("extensions.zotfile.renameFormat", "{%b}_{%t}");
    user_pref("extensions.zotfile.renameFormat_patent", "{%b}_{%t}");
    user_pref("extensions.zotfile.replace_blanks", true);

    user_pref("extensions.zutilo.itemmenu.modifyAttachments", "Zutilo");
    user_pref("extensions.zutilo.itemmenu.showAttachments", "Zutilo");

    user_pref("extensions.zotero.sortCreatorAsString", true);
    user_pref("extensions.zotero.secondarySort.title", "year");
    user_pref("extensions.zotero.secondarySort.firstCreator", "year");

    user_pref("extensions.shortdoi.autoretrieve", "short");

    user_pref("font.default.x-western", "${font.name}");
  '';
})
