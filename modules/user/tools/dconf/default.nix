# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ config, pkgs, lib, ... }:

with lib.hm.gvariant;

{
  config.home.packages = [
    pkgs.dconf
  ];
}
