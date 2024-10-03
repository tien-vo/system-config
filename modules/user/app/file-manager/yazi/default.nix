{ config, pkgs, ... }:
{
  config.programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  imports = [
    ./init.nix
    ./manager.nix
    ./open.nix
    ./theme.nix
  ];
}
