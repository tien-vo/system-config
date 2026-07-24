{ pkgs, settings, ... }:
let
  inherit (settings) src nixVersion;
in
{
  imports = [ "${src}/profiles/personal-laptop" ];
  config.home = {
    stateVersion = stateVersion;
    username = "tvo";
    homeDirectory = "/home/tvo";
  };
  config.programs.home-manager.enable = true;
  config.targets.genericLinux.enable = true;
}
