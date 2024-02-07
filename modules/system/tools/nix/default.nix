{ pkgs, ... }:
{
  config.nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      use-xdg-base-directories = true;
    };
  };
}
