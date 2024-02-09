inputs:
let
  inherit (inputs.nix-colors.colorSchemes) gruvbox-dark-medium;

  src = ../.;
  arch = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${arch};
  lib = inputs.nixpkgs.lib;

  gruvbox-icons = import ("${src}/packages/gruvbox-icons") (pkgs);
  colorScheme = gruvbox-dark-medium;
in
{
  inherit src arch pkgs;
  nixVersion = "23.11";
  monitors = {
    framework13 = {
      name = "BOE 0x0BCA";
      resolution = "2256x1504@60";
      screenScaling = 1.6;
      fontScaling = 1.4;
    };
    sceptre = {
      name = "Sceptre Tech Inc Sceptre F24 0x00000001";
      resolution = "1920x1080@60";
      screenScaling = 1;
      fontScaling = 1;
    };
  };
  window = {
    gap = {
      inner = 4;
      outer = 8;
    };
    border = {
      size = 2;
      radius = 6;
      active_color = {
        top = "d8a657";
        bottom = colorScheme.palette.base09;
      };
      inactive_color = colorScheme.palette.base04;
    };
  };
  theme = {
    colorScheme = colorScheme;
    wallpaper = "${src}/assets/wallpapers/gruvbox-dark-rainbow.png";
    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-Dark-BL";
    };
    font = {
      name = "FiraMono Nerd Font";
      size = 10;
    };
    iconTheme = {
      package = gruvbox-icons;
      name = "GruvboxIcons";
    };
    cursorTheme = {
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Gruvbox)";
      size = 24;
    };
  };
}
