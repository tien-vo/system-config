{ config, pkgs, ... }:
{
  config.home.packages = [
    pkgs.micromamba
  ];

  config.xdg.configFile."mamba/mambarc".source = ./mambarc;
  config.home.sessionVariables = {
    MAMBA_ROOT_PREFIX = "${config.xdg.dataHome}/micromamba";
  };
  config.programs.zsh.initExtra = ''
  eval "$(micromamba shell hook --shell zsh)"
  '';
}
