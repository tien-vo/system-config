{ pkgs, ... }:
{
  config.nix = {
    package = pkgs.nixFlakes;
    settings.use-xdg-base-directories = true;
  };
  config.nixpkgs.config = {
    allowUnfree = true;
  };
  config.home.packages = [
    pkgs.nix-index
  ];
}
