{ pkgs, settings, ... }:
let
  inherit (settings) src nixVersion;
in
{
  imports = [ "${src}/profiles/work" ];
  config.home = {
    stateVersion = nixVersion;
    username = "tvo";
    homeDirectory = "/home/tvo";
  };
  config.programs.home-manager.enable = true;
}
