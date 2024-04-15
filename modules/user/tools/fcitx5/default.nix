{ pkgs, ... }:
{
  config.i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = [
        pkgs.fcitx5-bamboo
      ];
    };
  };
}
