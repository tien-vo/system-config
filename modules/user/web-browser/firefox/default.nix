{ config, pkgs, settings, ... } @ args:
{
  imports = [ ./policies.nix ];

  config.programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    configPath = ".mozilla/firefox";
    #  configPath = "${config.xdg.configHome}/mozilla/firefox";
    profiles.custom-profile = {
      id = 0;
      name = "Custom profile";
      userChrome = import (./userChrome.nix);
      extraConfig = builtins.readFile( import (./userjs.nix) (args) );
    };
  };
  config.home.sessionVariables = {
    BROWSER = "${pkgs.firefox}/bin/firefox";
  };
}
