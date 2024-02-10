{ ... }:
{
  imports = [
    ./settings.nix
    ./style.nix
  ];
  config.programs.waybar.enable = true;
}
