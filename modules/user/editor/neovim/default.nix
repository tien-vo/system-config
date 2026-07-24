{ pkgs, settings, ... }:
let
  inherit (settings) src;
in
{
  imports = [
    "${src}/modules/user/development-environment/tectonic"
  ];
  config.programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.gcc
    ];
    withRuby = true;
    withPython3 = true;
  };
  config.home.file."./.config/nvim/" = {
    source = ./config;
    recursive = true;
  };
  config.home.packages = [
    pkgs.ripgrep
    pkgs.fd
  ];
}
