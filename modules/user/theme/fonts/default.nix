{ config, pkgs, ... }:
{
  config.home.packages = [
    pkgs.corefonts
    pkgs.nerd-fonts.roboto-mono
    pkgs.nerd-fonts.fira-mono
    pkgs.nerd-fonts.inconsolata
    pkgs.nerd-fonts.inconsolata-go
    pkgs.nerd-fonts.dejavu-sans-mono
  ];
  config.fonts.fontconfig.enable = true;
}
