{ inputs, pkgs, ... }:
{
  config.home.packages = [
    pkgs.cachix
    inputs.devenv.packages.${pkgs.system}.devenv
  ];
}
