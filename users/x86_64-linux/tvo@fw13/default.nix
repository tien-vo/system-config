{ pkgs, settings, ... }:
let
  inherit (settings) src stateVersion;
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
