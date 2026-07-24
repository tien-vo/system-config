{ inputs, pkgs, src, ... }:
let
  inherit (inputs.nix-colors.colorSchemes) gruvbox-dark-medium;

  color-scheme = gruvbox-dark-medium;
in
{
  monitors = {
    framework13 = {
      name = "BOE 0x0BCA";
      resolution = "2256x1504@60";
      screenScaling = 1.33333;
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
      size = 1;
      radius = 6;

      active_color = {
        top = "d8a657";
        bottom = color-scheme.palette.base09;
      };

      inactive_color =
        color-scheme.palette.base04;
    };
  };

  theme = {
    colorScheme = color-scheme;

    wallpaper =
      "${src}/assets/wallpapers/framework-4.png";

    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-Dark";
    };

    font = {
      name = "DejaVuSansM Nerd Font";
      size = 10;
    };

    iconTheme = {
      package = pkgs.gruvbox-plus-icons;
      name = "GruvBox-Plus-Dark";
    };

    cursorTheme = {
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Gruvbox)";
      size = 24;
    };
  };
}
