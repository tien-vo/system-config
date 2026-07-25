{ pkgs, ... }:
{
  imports = [
    ./backends/filen.nix
    ./backends/proton.nix
    ./notifications.nix
    ./secrets.nix
  ];

  config.home.packages = [
    pkgs.age
    pkgs.rclone
    pkgs.restic
    pkgs.sops
  ];

  config.services.restic.enable = true;
}
