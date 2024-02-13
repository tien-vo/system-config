{ pkgs, settings, ... }:
let
  inherit (builtins) toString;
  inherit (settings.theme) font;
in pkgs.writeTextFile ({
  name = "user.js";
  text = ''
user_pref("browser.theme.content-theme", 0);
user_pref("browser.theme.toolbar-theme", 0);
user_pref("font.name.sans-serif.x-western", "${font.name}");
user_pref("font.size.variable.x-western", ${toString(font.size)});
user_pref("privacy.donottrackheader.enabled", true);
user_pref("mail.spam.manualMark", true);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("messenger.options.messagesStyle.variant", "Dark");
user_pref("mail.pane_config.dynamic", 0);
  '';
})
