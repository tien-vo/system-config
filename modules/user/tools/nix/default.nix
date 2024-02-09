{ pkgs, ... }:
{
  config.nix = {
    package = pkgs.nixFlakes;
    settings.use-xdg-base-directories = true;
  };
  config.nixpkgs.config = {
    allowUnfree = true;
  };
}
