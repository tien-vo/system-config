{ settings, user-name, ... }:
let
  inherit (settings) src stateVersion;
in
{
  imports = [
    "${src}/profiles/personal-laptop"
  ];

  config.home = {
    stateVersion = stateVersion;
    username = user-name;
    homeDirectory = "/home/${user-name}";
  };

  config.programs.home-manager.enable = true;
  config.targets.genericLinux.enable = true;
}
