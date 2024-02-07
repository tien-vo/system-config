{ pkgs, ... }:
{
  config.home.packages = [
    pkgs.inconsolata-nerdfont
    (pkgs.nerdfonts.override ({ fonts = [ "RobotoMono" ]; }))
    pkgs.gtk-engine-murrine
  ];
  config.fonts.fontconfig.enable = true;
}
