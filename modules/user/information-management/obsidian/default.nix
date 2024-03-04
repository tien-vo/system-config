{ pkgs, ... }:
{
  config.nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  config.home.packages = [
    pkgs.obsidian
  ];
}
