{ pkgs, ... }:
{
  config.programs.zathura = {
    enable = true;
  };

  config.home.packages = [
    pkgs.xdotool
  ];
}
