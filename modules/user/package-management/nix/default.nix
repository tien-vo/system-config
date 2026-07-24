{ config, pkgs, ... }:
{
  config.nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      use-xdg-base-directories = true;
      trusted-users = [
        "root"
        "@wheel"
        "tvo"
      ];
    };
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
