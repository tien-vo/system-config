{ config, pkgs, ... }:
{
  config.programs.yazi.settings = {
    opener = {
      edit = [
        { run = ''${pkgs.neovim}/bin/nvim "$@"''; block = true; }
      ];
      play = [
        { run = ''${pkgs.vlc}/bin/vlc "$@"''; orphan = true; for = "unix"; }
      ];
      view = [
        { run = ''${pkgs.imv}/bin/imv -b ffffff "$@"''; orphan = true; for = "unix"; }
      ];
      open = [
        { run = ''${pkgs.xdg-utils}/bin/xdg-open "$@"''; desc = "Open"; }
      ];
    };

    open = {
      prepend_rules = [
        { name = "*.png"; use = "view"; }
        { name = "*.avi"; use = "play"; }
        { name = "*.mp3"; use = "play"; }
      ];
    };
  };
}
