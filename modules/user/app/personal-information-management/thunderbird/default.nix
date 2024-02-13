{ pkgs, ... } @ args:
{
  config.programs.thunderbird = {
    enable = true;
    profiles.custom-profile = {
      isDefault = true;
      userChrome = import (./userChrome.nix);
      extraConfig = import (./userjs.nix) (args);
    };
  };
}
