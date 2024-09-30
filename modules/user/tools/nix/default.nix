{ pkgs, settings, inputs, ... }:
let
  pkgs = import inputs.nixpkgs({
    system = settings.arch;
    overlays = [ inputs.nixgl.overlay ];
  });
in
{
  config.nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      use-xdg-base-directories = true;
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
    pkgs.nixgl.nixGLIntel
  ];
}
