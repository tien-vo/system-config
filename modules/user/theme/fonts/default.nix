{ pkgs, ... }:
let
  fonts = [
    "RobotoMono"
    "FiraMono"
    "Inconsolata"
    "InconsolataGo"
    "DejaVuSansMono"
  ];
in
{
  config.home.packages = [
    (pkgs.nerdfonts.override ({ inherit fonts; }))
    pkgs.gtk-engine-murrine
  ];
  config.fonts.fontconfig.enable = true;
}
