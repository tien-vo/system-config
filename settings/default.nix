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
  screen = {
    scaling = 1.6;
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
      name = "InconsolataGo Nerd Font";
      size = 11;
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
