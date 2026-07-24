{ config, pkgs, ... }:
{
  config.programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
  };

  imports = [
    ./init.nix
    ./manager.nix
    ./open.nix
    ./theme.nix
  ];
}
