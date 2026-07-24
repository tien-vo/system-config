{ pkgs, ... } @ args:
let
  thunderbird = pkgs.thunderbird.override ({
    extraPolicies = import (./policies.nix) (args);
  });
in
{
  config.home.packages = [
    thunderbird
  ];

  config.home.file."./.thunderbird/profiles.ini".source = ./profiles.ini;
  config.home.file."./.thunderbird/custom-profile/user.js".source = import (./userjs.nix) (args);
}
