{ pkgs, ... }:
{
  config.nix = {
    package = pkgs.nixFlakes;
    settings.use-xdg-base-directories = true;
  };
  config.nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "freeimage-unstable-2021-11-01"
    ];
  };
  config.home.packages = [
    pkgs.nix-index
  ];
}
