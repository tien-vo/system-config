{ pkgs, settings, ... }:
let
  inherit (settings) src;
in
{
  imports = [
    "${src}/modules/user/devenv/tectonic"
  ];
  config.programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.gcc
      pkgs.python311Full
      pkgs.python311Packages.pip
    ];
  };
  config.home.file."./.config/nvim/" = {
    source = ./config;
    recursive = true;
  };
}
