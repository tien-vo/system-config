{ config, settings, pkgs, ... }:
let
  proton-drive-cli = pkgs.callPackage
    "${settings.src}/packages/proton-drive-cli"
    { };
in
{
  config.home.packages = [
    proton-drive-cli
  ];
}
