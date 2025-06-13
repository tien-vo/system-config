{ config, settings, inputs, ... }:
let
  micromamba = inputs.nixpkgs-micromamba.legacyPackages.${settings.arch}.micromamba;
in
{
  config.home.packages = [
    micromamba
  ];

  config.xdg.configFile."mamba/mambarc".source = ./mambarc;
  config.home.sessionVariables = {
    MAMBA_ROOT_PREFIX = "${config.xdg.dataHome}/mamba";
  };
  config.programs.zsh.initExtra = ''
    eval "$(micromamba shell hook --shell zsh)"
  '';
}
