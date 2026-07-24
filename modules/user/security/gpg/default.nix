{ config, pkgs, ... }:
{
  config.programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
    settings = {
    };
  };

  config.services.gpg-agent = {
    enable = true;
    extraConfig = ''
      pinentry-program ${pkgs.pinentry-gnome3}/bin/pinentry-gnome3
    '';
  };
}
