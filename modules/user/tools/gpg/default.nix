{ config, ... }:
{
  config.programs.gpg = {
    enable = true;
    homeDir = "${config.xdg.dataHome}/gnupg";
    settings = {
    };
  };
}
