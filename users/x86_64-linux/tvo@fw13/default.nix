{ pkgs, settings, ... }:
let
  inherit (settings) src nixVersion;
in
{
  imports = [ "${src}/profiles/personal" ];
  config.home = {
    stateVersion = nixVersion;
    username = "tvo";
    homeDirectory = "/home/tvo";
  };
  config.programs.home-manager.enable = true;
  config.targets.genericLinux.enable = true;
}
