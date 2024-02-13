{ pkgs, ... } @ args:
let
  policies = import(./policies.nix)({});
  betterbird = pkgs.betterbird.override (old: {
    extraPolicies = (old.extraPolicies or {}) // policies;
  });
in
{
  config.home.packages = [
    betterbird
  ];

  config.home.file."./.thunderbird/profiles.ini".source = ./profiles.ini;
  config.home.file."./.thunderbird/custom-profile/user.js".source = import(./userjs.nix)(args);
}
