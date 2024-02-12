{ pkgs, ... }:
{
  config.accounts.email.accounts."tvo" = {
    primary = true;
    realName = "Tien Vo";
    address = "tvo.email@proton.me";
    thunderbird.enable = true;
  };
  config.programs.thunderbird = {
    enable = true;
    profiles.custom-profile = {
      isDefault = true;
      userChrome = import (./userChrome.nix);
      extraConfig = import (./userjs.nix);
    };
  };
  config.home.packages = [
    pkgs.protonmail-bridge
  ];
}
