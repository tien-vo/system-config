{ config, pkgs, ... }:
{
  config.programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  imports = [
    ./open.nix
    ./theme.nix
  ];
}
