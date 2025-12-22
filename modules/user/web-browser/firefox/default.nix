{ config, pkgs, settings, ... } @ args:
{
  imports = [ ./policies.nix ];

  config.programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
    profiles.custom-profile = {
      name = "Custom profile";
      isDefault = true;
      userChrome = import (./userChrome.nix);
      extraConfig = builtins.readFile( import (./userjs.nix) (args) );
    };
  };
  config.home.sessionVariables = {
    BROWSER = "${pkgs.firefox-esr}/bin/firefox-esr";
  };
}
