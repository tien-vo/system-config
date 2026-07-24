{ config, pkgs, settings, inputs, ... }:
let
  inherit (settings) arch;
  micromamba = inputs.nixpkgs-micromamba.legacyPackages.${arch}.micromamba;
in
{
  config.home.packages = [
    micromamba
  ];

  config.xdg.configFile."mamba/mambarc".source = ./mambarc;
  config.home.sessionVariables = {
    MAMBA_ROOT_PREFIX = "${config.xdg.dataHome}/mamba";
  };
  config.programs.zsh.initContent = ''
    eval "$(micromamba shell hook --shell zsh)"
  '';
}
