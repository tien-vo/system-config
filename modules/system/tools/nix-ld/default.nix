{ pkgs, inputs, ... }:
let
  inherit (pkgs.hostPlatform) system;
in
{
  config.programs.nix-ld = {
    enable = true;
    package = inputs.nix-ld-rs.packages.${system}.nix-ld-rs;
    libraries = [
      pkgs.gcc
      pkgs.micromamba
    ];
  };
}
