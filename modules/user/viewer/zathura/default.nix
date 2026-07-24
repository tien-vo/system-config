{ pkgs, ... }:
{
  config.programs.zathura = {
    enable = true;
    options = {
      zoom-max = 2000;
    };
  };

  config.home.packages = [
    pkgs.xdotool
    pkgs.zathuraPkgs.zathura_pdf_poppler
  ];
}
